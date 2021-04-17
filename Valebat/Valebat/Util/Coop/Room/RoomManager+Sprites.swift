//
//  RoomManager+Sprites.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import Foundation

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

        roomRef.getDocument { (document, error) in
            if let err = error {
                print("[Load Sprites] Database error: \(err)")
            } else {
                do {
                    guard let data = document?.data()?["sprites"] else {
                        print("[Load Sprites] Data not found.")
                        return
                    }

                    do {
                        let deserialisedData = try JSONSerialization.data(withJSONObject: data, options: [])
                    } catch {
                        print("Failed to decode sprites.")
                    }

                    let decoder = JSONDecoder()
                    // let decodedSprites = try? decoder.decode([SpriteData].self, from: data) {
//                    data.forEach { sprite in
//                        print("asdafe")
//                        print(sprite)
//                        // let spriteData = Data(from: sprite)
//                        // decoder.decode(SpriteData.self, from: spriteData)
//                    }
                    // print(document?.data())
                }
            }
        }
    }
}
