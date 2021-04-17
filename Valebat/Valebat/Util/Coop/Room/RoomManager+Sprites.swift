//
//  RoomManager+Sprites.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import Foundation
import FirebaseFirestore

extension RoomManager {
    func updateSprites(_ sprites: Set<SpriteData>) {
        guard let guaranteedRoom = self.room else {
            return
        }
        guaranteedRoom.sprites = Array(sprites)

        var sprites = [Any]()

        for sprite in guaranteedRoom.sprites {
            do {
                let jsonData = try JSONEncoder().encode(sprite)
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                sprites.append(jsonObject)
            } catch {
                print("Failed to encode sprite.")
            }
        }

        fdb.collection("rooms").document(guaranteedRoom.idx!).setData([ "sprites": sprites ],
                                                                      merge: true)
    }

    func loadSprites() {
        guard let guaranteedRoom = self.room else {
            return
        }

        let roomRef = fdb.collection("rooms").document(guaranteedRoom.idx!)

        roomRef.getDocument { (document, _) in
            guard let data = document?.data()?["sprites"] else {
                print("[Load Sprites] Data not found.")
                return
            }

            guard let dataArr = data as? [Any] else {
                print("conversion failed")
                return
            }

            var spriteDataSet = Set<SpriteData>()

            for rawData in dataArr {
                guard let rawSpriteData = rawData as? [String: Any] else {
                    print("convert to string failed")
                    continue
                }
                if let spData = SpriteData(data: rawSpriteData) {
                    spriteDataSet.insert(spData)
                }
            }

            guaranteedRoom.sprites = Array(spriteDataSet)

            print(spriteDataSet)
        }
    }
}
