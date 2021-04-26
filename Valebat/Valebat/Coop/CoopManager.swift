//
//  CoopManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import GameplayKit

class CoopManager {
    var spritesData: Set<SpriteData> = Set()
    var coopHUDData: CoopHUDData?
    var entityManager: CoopEntityManager
    var coopGameSession: CoopGameSession!

    init(coopEntityManager: CoopEntityManager) {
        self.entityManager = coopEntityManager
        self.coopGameSession = coopEntityManager.currentSession as? CoopGameSession
        initialiseLoadInputCycle()
    }

    func saveData(spriteComponents: [GKComponent]) {
        spritesData = Set()
        for spriteComp in spriteComponents {
            guard let spriteComp = spriteComp as? SpriteComponent,
                  let spriteNode = spriteComp.node as? SKSpriteNode else {
                continue
            }
            if let spData = SpriteData.initialise(spNode: spriteNode, idx: spriteComp.idx) {
                spritesData.insert(spData)
            }
        }
        coopHUDData = CoopHUDData(session: coopGameSession)
        for (string, player) in entityManager.clientPlayers {
            coopHUDData?.playercurrentHP[string] = player.component(conformingTo: HealthComponent.self)?.currentHealth
        }
        updateDatabase()
    }

    func updateDatabase() {
        coopGameSession.roomManager.updateData(sprites: spritesData, playerHUDData: coopHUDData)
    }

    private func initialiseLoadInputCycle() {
        coopGameSession.roomManager.loadUserInputCycle()
    }
}
