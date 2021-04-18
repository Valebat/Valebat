//
//  CoopEntityManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation
import SpriteKit
import GameplayKit

class CoopEntityManager: EntityManager {
    var timer: Double = 0.0

    var clientPlayers = [String: ClientPlayerEntity]()
    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        timer += Double(deltaTime)

        if timer > CoopConstants.updateTimer {
            saveSprites()
            timer -= CoopConstants.updateTimer
        }
        clientPlayers.keys.forEach({ self.handleClientPlayerUpdate(clientID: $0) })
    }

    private func handleClientPlayerUpdate(clientID: String) {

        // TODO: update clientPlayers here
    }

    func addClientPlayer(playerID: String) {
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        guard let playerStats = currentSession?.playerStats else {
            return
        }
        let character = ClientPlayerEntity(playerId: playerID, position: spawnLocation, playerStats: playerStats, entityManager: self)
        add(character)
        clientPlayers[playerID] = character
    }

    private func saveSprites() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveSprites(spriteComponents: spriteComponents)
    }
}
