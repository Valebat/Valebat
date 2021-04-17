//
//  GameScene.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/3/21.
//

import SpriteKit
import GameplayKit

class GameScene: BaseGameScene {
    weak var viewController: GameViewController?
    var userConfig: UserConfig

    // Entity-component system
    var gameSession: BaseGameSession!
    var persistenceManager: PersistenceManager!

    init(size: CGSize, userConfig: UserConfig) {
        self.userConfig = userConfig
        super.init(size: size)
    }

    override func sceneDidLoad() {
        var entityManager = EntityManager(scene: self)

        if self.userConfig.isCoop {
            entityManager = CoopEntityManager(scene: self)
        }

        persistenceManager = PersistenceManager()
        gameSession = loadGameSession(entityManager: entityManager, userConfig: userConfig)
        super.sceneDidLoad()
    }

    func loadGameSession(entityManager: EntityManager, userConfig: UserConfig) -> BaseGameSession {
        if userConfig.isCoop {
            return loadCoopGameSession(entityManager: entityManager, userConfig: userConfig)
        } else {
            return loadSinglePlayerGameSession(entityManager: entityManager, userConfig: userConfig)
        }
    }

    func loadCoopGameSession(entityManager: EntityManager, userConfig: UserConfig) -> BaseGameSession {
        guard let coopEntityManager = entityManager as? CoopEntityManager else {
            print("Failed to load co-op entity manager.")
            fatalError()
        }
        let currentSession = CoopGameSession(coopEntityManager: coopEntityManager,
                                             userConfig: userConfig,
                                             roomManager: userConfig.roomManager!)

        currentSession.loadGame()

        return currentSession
    }

    func loadSinglePlayerGameSession(entityManager: EntityManager, userConfig: UserConfig) -> BaseGameSession {
        let currentSession = GameSession(entityManager: entityManager, userConfig: userConfig)
        currentSession.persistenceManager = persistenceManager
        persistenceManager.gameSession = currentSession

        currentSession.loadGame()

        return currentSession
    }

    override func setUpScene() {
        super.setUpScene()
        gameSession.entityManager.addPlayer()
    }

    override func setUpUserInputHUD() {
        super.setUpUserInputHUD()
        inputHUDDisplay.assignInputDelegate(delegate: gameSession.entityManager)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        playerHUDDisplay.updateHUD(gameSession: gameSession)
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        AudioManager.update(seconds: deltaTime)
        // Update entities
        gameSession.entityManager.update(deltaTime)

        self.lastUpdateTime = currentTime

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
