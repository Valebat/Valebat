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
    var ref: DatabaseReference = Database.database().reference()
    var room: Room?
    private(set) var realTimeData = RealTimeData()

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
        self.ref.updateChildValues(allUpdates)
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

        self.ref.child("sprites/\(roomIdx)/data").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                if let string = snapshot.value as? String {
                    self.realTimeData.sprites = SpriteData.convertToSpriteData(dataString: string)
                }
            }
            completed()
        }
    }

    private func loadPlayerHUD(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        self.ref.child("playerHUD/\(roomIdx)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                print(snapshot)
                let hudData = snapshot.value as? [String: Any] ?? [:]
                guard let playerHUD = CoopHUDData(data: hudData) else {
                    return
                }
                self.realTimeData.playerHUDData = playerHUD
            }
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
        self.ref.updateChildValues(request)
    }

    private func loadUserInfo(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        self.ref.child("playerInput/\(roomIdx)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                let groupUserInfo = snapshot.value as? [String: Any] ?? [:]
                self.processUserInputInfos(info: groupUserInfo)
            }
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

    /*private func processRoomSprites(spritesData: [String: Any]) -> Set<SpriteData> {
        var spriteDataSet = Set<SpriteData>()
        for (idx, data) in spritesData {
            var rawSpriteData = data as? [String: Any] ?? [:]
            rawSpriteData["idx"] = idx
            if let spData = SpriteData(data: rawSpriteData) {
                spriteDataSet.insert(spData)
            }
        }
        return spriteDataSet
    }*/

    var numberOfFields = 8
    private func convertSpriteDataToString(sprites: Set<SpriteData>) -> String {
        var string = ""
        for data in sprites {
            string.append(data.idx.uuidString)
            string.append(",")
            string.append(data.name)
            string.append(",")
            if data.name.contains(",") || data.name.contains(" ") {
                print("yikes")
            }
            string.append(String(data.width))
            string.append(",")
            string.append(String(data.height))
            string.append(",")
            string.append(String(data.xPos))
            string.append(",")
            string.append(String(data.yPos))
            string.append(",")
            string.append(String(data.zPos))
            string.append(",")
            string.append(String(data.orientation))
            string.append(" ")
        }
        return string
    }
    private func convertStringToStringData(string: String) -> [SpriteData] {
        var spriteData = [SpriteData]()
        let array = string.split(separator: " ").map({ String($0) })
        array.forEach({ value in
            let fields = value.split(separator: ",").map({ String($0) })
            if fields.count != numberOfFields {
                return
            }
            guard let uid = UUID(uuidString: fields[0]),
                  let width = Float(fields[2]),
                  let height = Float(fields[3]),
                  let xPos = Float(fields[4]),
                  let yPos = Float(fields[5]),
                  let zPos = Float(fields[6]),
                  let orientation = Float(fields[7]) else {
                return
            }
            let name = fields[1]
            spriteData.append(SpriteData(idx: uid, name: name, width: width,
                                         height: height, xPos: xPos, yPos: yPos, zPos: zPos, orientation: orientation))
        })
        return spriteData
    }
}
