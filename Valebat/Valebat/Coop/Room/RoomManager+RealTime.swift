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

    func loadSprites() {
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
            } else {
                print("No data available")
            }
        }
    }

    func saveUserInfo(playerId: String) {
        guard let guaranteedRoom = self.room,
              let idx = guaranteedRoom.idx,
              let userInfo = realTimeData.userInputInfo[idx] else {
            return
        }
        let request = userInfo.convertToDBRequest(playerId: playerId, roomId: idx)
        self.ref.updateChildValues(request)
    }

    func loadUserInfo() {
        guard let guaranteedRoom = self.room else {
            return
        }

        self.ref.child("playerInput/\(guaranteedRoom.idx!)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                let groupUserInfo = snapshot.value as? [String: Any] ?? [:]

            } else {
                print("No data available")
            }
        }
    }

    private func processUserInputInfos(info: [String: Any]) {

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
