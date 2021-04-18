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

    func updateSprites(_ sprites: Set<SpriteData>) {
        guard let guaranteedRoom = self.room else {
            return
        }
        self.ref.child("sprites/\(guaranteedRoom.idx!)").removeValue()

        realTimeData.sprites = Array(sprites)

        var allUpdates = [String: Any]()

        for sprite in realTimeData.sprites {
            let updates = [
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/name": sprite.name,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/width": sprite.width,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/height": sprite.height,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/xPos": sprite.xPos,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/yPos": sprite.yPos,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/zPos": sprite.zPos,
                "sprites/\(guaranteedRoom.idx!)/\(sprite.idx)/orientation": sprite.orientation
              ] as [String: Any]

            allUpdates.merge(updates, uniquingKeysWith: {(current, _) in current})
        }

        self.ref.updateChildValues(allUpdates)
    }
    func updateHUD() {

    }

    func loadSpritesCycle() {
        loadSprites { [self] in
            loadSpritesCycle()
        }
    }

    func loadUserInputCycle() {
        loadUserInfo { [self] in
            loadUserInputCycle()
        }
    }

    func loadSprites(completed: @escaping () -> Void) {
        guard let guaranteedRoom = self.room else {
            return
        }

        self.ref.child("sprites/\(guaranteedRoom.idx!)").getData { (error, snapshot) in
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
        guard let guaranteedRoom = self.room else {
            return
        }
        self.ref.child("playerInput/\(guaranteedRoom.idx!)").getData { (error, snapshot) in
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
