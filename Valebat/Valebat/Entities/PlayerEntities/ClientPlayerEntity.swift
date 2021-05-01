//
//  ClientPlayerEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 17/4/21.
//

import Foundation
import GameplayKit

class ClientPlayerEntity: PlayerEntity {
    var playerId: String

    init(playerId: String, position: CGPoint, playerStats: PlayerStats, entityManager: EntityManager) {
        self.playerId = playerId
        super.init(position: position, playerStats: playerStats,
                   playerSpellComp: ClientPlayerAimAndShootComponent(), entityManager: entityManager)
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let entityManager = entityManager as? CoopEntityManager else {
            return
        }
        guard let session = entityManager.currentSession as? CoopGameSession else {
            return
        }
        let inputInfos = session.roomManager.realTimeData.userInputInfo
        self.userInputInfo = inputInfos[playerId]

        for component in self.components {
            component.update(deltaTime: seconds)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
