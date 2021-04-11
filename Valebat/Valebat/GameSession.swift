//
//  GameSession.swift
//  Valebat
//
//  Created by Aloysius Lim on 7/4/21.
//

import Foundation

class GameSession {
    var playerStats: PlayerStats
    var currentLevel: Int
    var entityManager: EntityManager

    let spellManager: SpellManager
    let objectiveManager: ObjectiveManager
    var mapManager: MapManager!
    let spawnManager: SpawnManager

    weak var persistenceManager: PersistenceManager?

    init(entityManager: EntityManager) {
        playerStats = PlayerStats()
        currentLevel = 0

        self.entityManager = entityManager
        self.spellManager = SpellManager()
        self.objectiveManager = ObjectiveManager()
        self.spawnManager = SpawnManager()
        self.mapManager = MapManager(entityManager: entityManager, spawnManager: spawnManager,
                                     objectiveManager: objectiveManager)
        entityManager.mapManager = mapManager
        entityManager.currentSession = self
    }
}
