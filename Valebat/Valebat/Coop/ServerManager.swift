//
//  ServerManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import GameplayKit

class ServerManager {
    var spritesData: Set<SpriteData> = Set()
    var coopHUDData: CoopHUDData?

    var gameNetworkManager: ServerGameNetworkManager

    weak var coopGameSession: CoopGameSession?
    weak var entityManager: CoopEntityManager?

    init(coopEntityManager: CoopEntityManager, room: Room?) {
        self.entityManager = coopEntityManager
        self.coopGameSession = coopEntityManager.currentSession as? CoopGameSession
        let gameNetworkManager = GameNetworkManager()
        gameNetworkManager.room = room
        self.gameNetworkManager = gameNetworkManager
        coopEntityManager.serverManager = self

        initialiseLoadInputCycle()
    }

    func saveData(spriteComponents: [GKComponent], resetAll: Bool) {
        guard let entityManager = self.entityManager,
              let coopGameSession = self.coopGameSession else {
            return
        }

        spritesData = Set()
        for spriteComp in spriteComponents {
            guard let spriteComp = spriteComp as? SpriteComponent,
                  let spriteNode = spriteComp.node as? SKSpriteNode else {
                continue
            }
            if spriteComp.isStatic && !resetAll {
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
        updateDatabase(resetAll: resetAll)
    }

    func updateDatabase(resetAll: Bool) {
        gameNetworkManager.updateGameData(sprites: spritesData, playerHUDData: coopHUDData, resetAll: resetAll)
    }

    private func initialiseLoadInputCycle() {
        gameNetworkManager.loadUserInputCycle()
    }
}
