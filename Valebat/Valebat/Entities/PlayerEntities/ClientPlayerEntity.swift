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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
