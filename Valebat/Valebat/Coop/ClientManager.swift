//
//  ClientManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 17/4/21.
//

import Foundation

class ClientManager {
    var spritesData: Set<SpriteData> = Set()
    var coopHUDData: CoopHUDData?
    var roomManager: RoomManager?
    var loadingIsInitialised: Bool = false

    private func initialiseLoadingCycle() {
        roomManager!.loadSpritesCycle()
        loadingIsInitialised = true
    }

    func getData() {
        if !loadingIsInitialised {
            initialiseLoadingCycle()
        }
        if let sprites = self.roomManager?.realTimeData.sprites {
            if sprites.count > 0 {
                spritesData = Set(sprites)
            }
        }
        if let coopHUD = self.roomManager?.realTimeData.playerHUDData {
            coopHUDData = coopHUD
        }
    }
}
