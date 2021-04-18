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

    var spellShoot = [String: Bool]()

    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        timer += Double(deltaTime)

        if timer > CoopConstants.updateTimer {
            saveData()
            timer -= CoopConstants.updateTimer
        }
        updateClientPlayers(deltaTime)
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

    private func updateClientPlayers(_ seconds: CFTimeInterval) {
        guard let session = currentSession as? CoopGameSession else {
            return
        }
        let inputInfos = session.roomManager.realTimeData.userInputInfo
        for (playerId, info) in inputInfos {
            let player = clientPlayers[playerId]
            updatePlayerPosition(seconds: seconds, player: player, userInput: info)
            updateClientShoot(userInput: info, player: player, playerId: playerId)
        }
    }

    private func updateClientShoot(userInput: UserInputInfo, player: PlayerEntity?,
                                   playerId: String) {
        if userInput.spellJoystickMoved {
            spellJoystickMoved(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            spellShoot[playerId] = false
        } else if userInput.spellJoystickEnd && !(spellShoot[playerId] ?? false) {
            spellJoystickEnded(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            userInput.spellJoystickEnd = false
            spellShoot[playerId] = true
        }
    }
}
