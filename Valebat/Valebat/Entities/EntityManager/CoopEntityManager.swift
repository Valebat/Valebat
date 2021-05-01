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
            saveData()
            timer -= CoopConstants.updateTimer
        }
    }

    func addClientPlayer(playerID: String) {
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        guard let playerStats = currentSession?.playerStats else {
            return
        }
        let character = ClientPlayerEntity(playerId: playerID, position: spawnLocation,
                                           playerStats: playerStats, entityManager: self)
        add(character)
        clientPlayers[playerID] = character
    }

    private func saveData() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveData(spriteComponents: spriteComponents)
    }

    override func advanceLevel() {
        super.advanceLevel()
        clientPlayers.values.forEach({ self.add($0) })
    }

    override func restart() {
        super.restart()
        clientPlayers.values.forEach({ self.add($0) })
    }
}
