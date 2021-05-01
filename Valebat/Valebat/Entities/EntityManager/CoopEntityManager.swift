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
    var smalltimer: Double = 0.0
    var clientPlayers = [String: ClientPlayerEntity]()

    weak var serverManager: ServerManager?

    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        timer += Double(deltaTime)
        smalltimer += Double(deltaTime)
        // saveData()
        if timer > CoopConstants.updateTimer {
            saveData(resetAll: true)
            timer -= CoopConstants.updateTimer
        } else {
            if smalltimer > 0.15 {
                saveData(resetAll: false)
                smalltimer = 0.0
            }
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

    private func saveData(resetAll: Bool) {
        var spriteComponents = spriteSystem.components
        serverManager?.saveData(spriteComponents: spriteComponents, resetAll: resetAll)
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
