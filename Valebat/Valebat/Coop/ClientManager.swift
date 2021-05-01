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
    var gameNetworkManager: ClientGameNetworkManager?
    var loadingIsInitialised: Bool = false

    private func initialiseLoadingCycle() {
        gameNetworkManager?.loadSpritesCycle()
        loadingIsInitialised = true
    }

    func getData() {
        if !loadingIsInitialised {
            initialiseLoadingCycle()
        }
        if let sprites = self.gameNetworkManager?.getSpritesData() {
            if sprites.count > 0 {
                spritesData = Set(sprites)
            }
        }
        if let coopHUD = self.gameNetworkManager?.getPlayerHUDData() {
            coopHUDData = coopHUD
        }
    }
}
