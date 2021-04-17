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

    var clientPlayers = [String: ClientPlayerEntity]()
    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)
        print(clientPlayers.capacity)
        if let vaal = clientPlayers.first?.value {
            print(vaal)
            print(vaal.component(conformingTo: MoveComponent.self)?.currentPosition)
        }
        print(clientPlayers.first?.value.playerId)
        saveSprites()
        // currentSession?.coopManager?.loadSprites()
    }

    func addClientPlayer(playerID: String) {
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        guard let playerStats = currentSession?.playerStats else {
            return
        }
        let character = ClientPlayerEntity(playerId: playerID, position: spawnLocation, playerStats: playerStats, entityManager: self)
        print("SDFdsfsdf")
        add(character)
        clientPlayers[playerID] = character
    }

    private func saveSprites() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveSprites(spriteComponents: spriteComponents)
    }
}
