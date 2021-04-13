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
    var userConfig: UserConfig

    let spellManager: SpellManager
    let objectiveManager: ObjectiveManager
    var mapManager: MapManager!
    let spawnManager: SpawnManager
    var coopManager: CoopManager?

    weak var persistenceManager: PersistenceManager?

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

        // TODO: can add conditional creation of coopmanager base on userconfig
        self.coopManager = CoopManager()
    }

    func loadGame() {
        if userConfig.isNewGame {
            persistenceManager?.loadInitialData()
        } else {
            persistenceManager?.load()
        }
    }
}
