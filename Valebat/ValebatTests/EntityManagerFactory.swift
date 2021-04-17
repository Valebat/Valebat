//
//  EntityManagerFactory.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

class EntityManagerFactory {

    private init() {}

    static func createEmptyEntityManager() -> EntityManager {
        return EntityManager(scene: GameScene(size: .zero,
                                              userConfig: UserConfig(isCoop: false,
                                                                     isNewGame: true,
                                                                     diffLevel: .easy)))
    }
}
