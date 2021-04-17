//
//  ClientManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 17/4/21.
//

import Foundation

class ClientManager {
    var spritesData: Set<SpriteData> = Set()
    var roomManager: RoomManager?

    /*func getChangedSprites(newSpritesData: Set<SpriteData>) -> Set<SpriteData> {
        var changedSprites = Set<SpriteData>()
        for sprite in spritesData {
            let newSprites = newSpritesData.filter({ $0.idx == sprite.idx })
            if newSprites.count != 1 {
                // Error or doesn't exist
                continue
            } else {
                guard let newSprite = newSprites.first else {
                    continue
                }
                if newSprite != sprite {
                    changedSprites.insert(newSprite)
                }
            }
        }
        return changedSprites
    }
    */
    func getSpriteData() {
        self.roomManager?.loadSprites()
        spritesData = Set(self.roomManager?.room?.sprites ?? [])
    }
}
