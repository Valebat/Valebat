//
//  GameSessionFactory.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

class GameSessionFactory {

    private init() {}

    static func createEmptyGameSession(entityManager: EntityManager?) -> GameSession {
        guard let manager = entityManager else {
            let eManager = EntityManagerFactory.createEmptyEntityManager()
            return GameSession(entityManager: eManager, userConfig: eManager.scene.userConfig)
        }
        return GameSession(entityManager: manager, userConfig: manager.scene.userConfig)
    }

    static func createGameSession(for levelType: LevelListTypeEnum, entityManager: EntityManager?) -> GameSession {
        guard let manager = entityManager else {
            return createEmptyGameSession(entityManager: EntityManagerFactory.createEmptyEntityManager())
        }
        let gameSession = createEmptyGameSession(entityManager: manager)
        gameSession.mapManager.generateMaps(withLevelType: levelType)
        return gameSession
    }
}
