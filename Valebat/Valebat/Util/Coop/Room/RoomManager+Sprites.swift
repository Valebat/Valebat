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
        guaranteedRoom.sprites = Array(sprites)

        var allUpdates = [String: Any]()

        for sprite in guaranteedRoom.sprites {
            let updates = [
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/name": sprite.name,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/width": sprite.width,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/height": sprite.height,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/xPos": sprite.xPos,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/yPos": sprite.yPos,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/zPos": sprite.zPos,
                "rooms/\(guaranteedRoom.idx!)/\(sprite.idx)/orientation": sprite.orientation
              ] as [String: Any]

            allUpdates.merge(updates, uniquingKeysWith: {(current, _) in current})
        }

        self.ref.updateChildValues(allUpdates)
    }

    func loadSprites() {
        print("load sprites called")
        guard let guaranteedRoom = self.room else {
            return
        }

        self.ref.child("rooms/\(guaranteedRoom.idx!)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                let roomData = snapshot.value as? [String: Any] ?? [:]
                let spriteDataSet = self.processRoom(roomData: roomData)
                guaranteedRoom.sprites = Array(spriteDataSet)
                print("spriteDataSet")
                print(spriteDataSet.count)
                print(spriteDataSet)
            } else {
                print("No data available")
            }
        }

//        let roomRef = fdb.collection("rooms").document(guaranteedRoom.idx!)

//        roomRef.getDocument { (document, _) in
//            guard let data = document?.data()?["sprites"] else {
//                print("[Load Sprites] Data not found.")
//                return
//            }
//
//            guard let dataArr = data as? [Any] else {
//                print("conversion failed")
//                return
//            }
//
//            var spriteDataSet = Set<SpriteData>()
//
//            print("dataArr")
//            print(dataArr)
//
//            for rawData in dataArr {
//                guard let rawSpriteData = rawData as? [String: Any] else {
//                    print("convert to string failed")
//                    continue
//                }
//                if let spData = SpriteData(data: rawSpriteData) {
//                    spriteDataSet.insert(spData)
//                }
//            }
//
//            guaranteedRoom.sprites = Array(spriteDataSet)
//
//            print("spriteDataSet")
//            print(spriteDataSet.count)
//            print(spriteDataSet)
//        }
    }

    private func processRoom(roomData: [String: Any]) -> Set<SpriteData> {
        var spriteDataSet = Set<SpriteData>()
        for (idx, data) in roomData {
            var rawSpriteData = data as? [String: Any] ?? [:]
            rawSpriteData["idx"] = idx
            if let spData = SpriteData(data: rawSpriteData) {
                spriteDataSet.insert(spData)
            }
        }
        return spriteDataSet
    }
}
