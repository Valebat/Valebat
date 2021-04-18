//
//  CoopManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import GameplayKit

class CoopManager {
    var spritesData: Set<SpriteData> = Set()
    var entityManager: CoopEntityManager
    var coopGameSession: CoopGameSession!

    init(coopEntityManager: CoopEntityManager) {
        self.entityManager = coopEntityManager
        self.coopGameSession = coopEntityManager.currentSession as? CoopGameSession
        initialiseLoadInputCycle()
    }

    func saveSprites(spriteComponents: [GKComponent]) {
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
        updateDatabase()
    }

    func updateDatabase() {
        coopGameSession.roomManager.updateSprites(spritesData)
    }

    private func initialiseLoadInputCycle() {
        coopGameSession.roomManager.loadSpritesCycle()
    }
}
