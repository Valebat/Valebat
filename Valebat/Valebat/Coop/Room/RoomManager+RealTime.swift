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
        self.ref.child("sprites/\(roomIdx)").removeValue()

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

    func loadSprites(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        self.ref.child("sprites/\(roomIdx)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                let spritesData = snapshot.value as? [String: Any] ?? [:]
                let spriteDataSet = self.processRoomSprites(spritesData: spritesData)
                self.realTimeData.sprites = Array(spriteDataSet)
            }
            completed()
        }
    }

    func loadPlayerHUD(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room,
              let roomIdx = guaranteedRoom.idx else {
            return
        }

        self.ref.child("playerHUD/\(roomIdx)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                let hudData = snapshot.value as? [String: Any] ?? [:]
                guard let playerHUD = CoopHUDData(data: hudData) else {
                    return
                }
                self.realTimeData.playerHUDData = playerHUD
            }
            completed()
        }
    }

    func saveUserInfo(playerId: String) {
        guard let guaranteedRoom = self.room,
              let idx = guaranteedRoom.idx,
              let userInfo = realTimeData.userInputInfo[playerId] else {
            return
        }

        let request = userInfo.convertToDBRequest(playerId: playerId, roomId: idx)
        self.ref.updateChildValues(request)
    }

    func loadUserInfo(completed: @escaping () -> Void) {
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
