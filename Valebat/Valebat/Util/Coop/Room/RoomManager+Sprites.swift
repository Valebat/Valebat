//
//  RoomManager+Sprites.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import Foundation

extension RoomManager {
    func updateSprites(_ sprites: Set<SpriteData>) {
        print("UpdateSprites called.")
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
                                                                      merge: false)
    }

    func loadSprites() {

    }
}
