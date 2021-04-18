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

    func getSpriteData() {
        self.roomManager?.loadSprites()
        if let sprites = self.roomManager?.realTimeData.sprites {
            if sprites.count > 0 {
                spritesData = Set(sprites)
            }
        }
    }
}
