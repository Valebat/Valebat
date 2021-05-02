//
//  ServerGameNetworkManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 1/5/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

protocol ServerGameNetworkManager: class {
    func updateGameData(sprites: Set<SpriteData>, playerHUDData: CoopHUDData?)
    func loadUserInputCycle()
    func getUserInputInfo() -> [String: UserInputInfo]
}

protocol ClientGameNetworkManager: class {
    func updateUserInfo(playerId: String, userInputInfo: UserInputInfo)
    func loadSpritesCycle()
    func getSpritesData() -> [SpriteData]
    func getPlayerHUDData() -> CoopHUDData?
}

class GameNetworkManager: ServerGameNetworkManager, ClientGameNetworkManager {
    var room: Room?
    private(set) var realTimeData = RealTimeData()
    var dbManager = DatabaseManager()

    var currentIDs = Set<UUID>()
    func getSpritesData() -> [SpriteData] {
        return realTimeData.sprites
    }

    func getPlayerHUDData() -> CoopHUDData? {
        return realTimeData.playerHUDData
    }

    func getUserInputInfo() -> [String: UserInputInfo] {
        return realTimeData.userInputInfo
    }

    func updateGameData(sprites: Set<SpriteData>, playerHUDData: CoopHUDData?) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }
        let dataString = SpriteData.convertToString(spriteData: sprites)
        realTimeData.sprites = Array(sprites)
        realTimeData.playerHUDData = playerHUDData
        var allUpdates = [String: Any]()
        var updates = [String: Any]()
        if let playerHUD = playerHUDData {
            let update = [
                "playerHUD/\(roomIdx)/playerLevel": playerHUD.playerLevel,
                "playerHUD/\(roomIdx)/currentLevel": playerHUD.currentLevel,
                "playerHUD/\(roomIdx)/currentEXP": playerHUD.currentEXP,
                "playerHUD/\(roomIdx)/objective": playerHUD.objective,
                "playerHUD/\(roomIdx)/maxHP": Float(playerHUD.maxHP)
              ] as [String: Any]
            update.forEach { updates[$0] = $1 }

            for (idx, hpLevel) in playerHUD.playercurrentHP {
                let key = "playerHUD/\(roomIdx)/playercurrentHP/\(idx)"
                updates[key] = Float(hpLevel)
            }
        }
        updates["sprites/\(roomIdx)/data"] = dataString
        allUpdates.merge(updates, uniquingKeysWith: {(current, _) in current})

        dbManager.updateValues(with: allUpdates)
    }

    func loadSpritesCycle() {
        loadSprites { [self] in
            loadPlayerHUD {
                loadSpritesCycle()
            }
        }
    }

    func loadUserInputCycle() {
        loadUserInfo { [self] in
            loadUserInputCycle()
        }
    }

    private func loadSprites(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        dbManager.getValue(from: "sprites/\(roomIdx)") { (spritesData) in
            if let string = spritesData["data"] as? String {
                self.realTimeData.sprites = SpriteData.convertToSpriteData(dataString: string)
            }
            completed()
        }
    }

    private func loadPlayerHUD(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }
        dbManager.getValue(from: "playerHUD/\(roomIdx)") { (hudData) in
            guard let playerHUD = CoopHUDData(data: hudData) else {
                return
            }
            self.realTimeData.playerHUDData = playerHUD
            completed()
        }
    }

    func updateUserInfo(playerId: String, userInputInfo: UserInputInfo) {
        realTimeData.userInputInfo[playerId] = userInputInfo
        guard let guaranteedRoom = self.room,
              let idx = guaranteedRoom.idx else {
            return
        }

        let request = userInputInfo.convertToDBRequest(playerId: playerId, roomId: idx)
        dbManager.updateValues(with: request)
    }

    private func loadUserInfo(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        dbManager.getValue(from: "playerInput/\(roomIdx)") { (groupUserInfo) in
            self.processUserInputInfos(info: groupUserInfo)
            completed()
        }
    }

    private func processUserInputInfos(info: [String: Any]) {
        for (idx, data) in info {
            let playerInputInfo = data as? [String: Any] ?? [:]
            if let userinfo = UserInputInfo(data: playerInputInfo) {
                realTimeData.userInputInfo[idx] = userinfo
            }
        }
    }

}
