//
//  RoomManager+Sprites.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

extension RoomManager {

    func updateData(sprites: Set<SpriteData>, playerHUDData: CoopHUDData?) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        realTimeData.sprites = Array(sprites)
        realTimeData.playerHUDData = playerHUDData
        var allUpdates = [String: Any]()

        var updates = [String: Any]()
        for sprite in realTimeData.sprites {
            let update = [
                "sprites/\(roomIdx)/\(sprite.idx)/name": sprite.name,
                "sprites/\(roomIdx)/\(sprite.idx)/width": sprite.width,
                "sprites/\(roomIdx)/\(sprite.idx)/height": sprite.height,
                "sprites/\(roomIdx)/\(sprite.idx)/xPos": sprite.xPos,
                "sprites/\(roomIdx)/\(sprite.idx)/yPos": sprite.yPos,
                "sprites/\(roomIdx)/\(sprite.idx)/zPos": sprite.zPos,
                "sprites/\(roomIdx)/\(sprite.idx)/orientation": sprite.orientation
              ] as [String: Any]
            update.forEach { updates[$0] = $1 }
        }

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

        allUpdates.merge(updates, uniquingKeysWith: {(current, _) in current})

        dbManager.removeValue(from: "sprites/\(roomIdx)", completed: { () in
            self.dbManager.updateValues(with: allUpdates)
        })
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

    func loadSprites(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        dbManager.getValue(from: "sprites/\(roomIdx)", completed: { (result) in
            let spriteDataSet = self.processRoomSprites(spritesData: result)
            self.realTimeData.sprites = Array(spriteDataSet)
            completed()
        })

    }

    func loadPlayerHUD(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        dbManager.getValue(from: "playerHUD/\(roomIdx)", completed: { (result) in
            guard let playerHUD = CoopHUDData(data: result) else {
                return
            }
            self.realTimeData.playerHUDData = playerHUD
            completed()
        })
    }

    func saveUserInfo(playerId: String) {
        guard let guaranteedRoom = self.room,
              let idx = guaranteedRoom.idx,
              let userInfo = realTimeData.userInputInfo[playerId] else {
            return
        }

        let request = userInfo.convertToDBRequest(playerId: playerId, roomId: idx)
        dbManager.updateValues(with: request)
    }

    func loadUserInfo(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        dbManager.getValue(from: "playerInput/\(roomIdx)", completed: { (result) in
            self.processUserInputInfos(info: result)
            completed()
        })
    }

    private func processUserInputInfos(info: [String: Any]) {
        for (idx, data) in info {
            let playerInputInfo = data as? [String: Any] ?? [:]
            if let userinfo = UserInputInfo(data: playerInputInfo) {
                realTimeData.userInputInfo[idx] = userinfo
            }
        }
    }

    private func processRoomSprites(spritesData: [String: Any]) -> Set<SpriteData> {
        var spriteDataSet = Set<SpriteData>()
        for (idx, data) in spritesData {
            var rawSpriteData = data as? [String: Any] ?? [:]
            rawSpriteData["idx"] = idx
            if let spData = SpriteData(data: rawSpriteData) {
                spriteDataSet.insert(spData)
            }
        }
        return spriteDataSet
    }
}
