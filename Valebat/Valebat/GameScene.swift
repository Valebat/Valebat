//
//  GameScene.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/3/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    weak var viewController: GameViewController?
    var userConfig: UserConfig

    // Entity-component system
    var gameSession: GameSession!
    var persistenceManager: PersistenceManager!

    var headsUpDisplay: UserInputNode!
    var playerHUDDisplay: PlayerHUD!
    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let entityManager = EntityManager(scene: self)
        persistenceManager = PersistenceManager()
        gameSession = loadGameSession(entityManager: entityManager, userConfig: userConfig)
        setUpScene()
    }

    func loadGameSession(entityManager: EntityManager, userConfig: UserConfig) -> GameSession {
        let currentSession = GameSession(entityManager: entityManager, userConfig: userConfig)
        currentSession.persistenceManager = persistenceManager
        persistenceManager.gameSession = currentSession

        currentSession.loadGame()

        return currentSession
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    private func setUpScene() {
        setUpUserInputHUD()
        setUpPlayerHUD()
        gameSession.entityManager.addPlayer()
    }

    private func setUpPlayerHUD() {
        guard let refNode = SKReferenceNode(fileNamed: "PlayerHUD") else {
            return
        }
        addChild(refNode)
        refNode.position = CGPoint(x: size.width/2, y: size.height/2)
        guard let baseNode = refNode.childNode(withName: "//baseHUD") as? PlayerHUD else {
            return
        }
        playerHUDDisplay = baseNode
        baseNode.xScale = size.width / baseNode.frame.width
        baseNode.yScale = size.height / baseNode.frame.height
    }

    private func setUpUserInputHUD() {
        headsUpDisplay = UserInputNode(screenSize: self.size)
        addChild(headsUpDisplay)
        headsUpDisplay.assignInputDelegate(delegate: gameSession.entityManager)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchMoved(toPoint: touch.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchUp(atPoint: touch.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchUp(atPoint: touch.location(in: self)) }
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

    init(size: CGSize, userConfig: UserConfig) {
        self.userConfig = userConfig
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
