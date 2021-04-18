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

    var spellShoot: Bool = false

    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        timer += Double(deltaTime)

        if timer > CoopConstants.updateTimer {
            saveSprites()
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

    private func saveSprites() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveSprites(spriteComponents: spriteComponents)
    }

    private func updateClientPlayers(_ seconds: CFTimeInterval) {
        guard let session = currentSession as? CoopGameSession else {
            print("not coop game")
            return
        }
        let inputInfos = session.roomManager.realTimeData.userInputInfo
        for (playerId, info) in inputInfos {
            let player = clientPlayers[playerId]
            updatePlayerPosition(seconds: seconds, player: player, userInput: info)
            updateShoot(userInput: info, player: player)
        }
    }

    override func updateShoot(userInput: UserInputInfo, player: PlayerEntity?) {
        if userInput.spellJoystickMoved {
            spellJoystickMoved(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            spellShoot = false
        } else if userInput.spellJoystickEnd && !spellShoot {
            spellJoystickEnded(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            spellShoot = true
        }
    }

}
