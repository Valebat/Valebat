//
//  RoomManager+Sprites.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

extension RoomManager {
    func updateSprites(_ sprites: Set<SpriteData>) {
        print("UpdateSprites called.")
        guard let guaranteedRoom = self.room else {
            return
        }
        guaranteedRoom.sprites = Array(sprites)
//        fdb.collection("rooms").document(guaranteedRoom.idx!).setData([ "sprites": guaranteedRoom.sprites ],
//                                                                      merge: false)
    }

    func loadSprites() {

    }
}
