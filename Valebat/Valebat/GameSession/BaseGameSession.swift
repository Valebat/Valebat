//
//  BaseGameSession.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation

class BaseGameSession {
    var playerStats: PlayerStats
    var currentLevel: Int
    var entityManager: EntityManager
    var userConfig: UserConfig

    let spellManager: SpellManager
    let objectiveManager: ObjectiveManager
    var mapManager: MapManager!
    let spawnManager: SpawnManager
    weak var persistenceManager: PersistenceManager?
    var coopManager: CoopManager?

    init(entityManager: EntityManager, userConfig: UserConfig) {
        playerStats = PlayerStats()
        currentLevel = 0

        self.userConfig = userConfig
        self.entityManager = entityManager
        self.spellManager = SpellManager()
        self.objectiveManager = ObjectiveManager()
        self.spawnManager = SpawnManager()
        self.mapManager = MapManager(entityManager: entityManager, spawnManager: spawnManager,
                                     objectiveManager: objectiveManager)
        entityManager.mapManager = mapManager
        entityManager.currentSession = self
    }

    func loadGame() {
        self.entityManager.setup()
    }
}
