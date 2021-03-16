//
//  GameScene.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/3/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // Entity-component system
    var entityManager: EntityManager!
    var graphs = [String: GKGraph]()

    var headsUpDisplay: HeadsUpDisplayNode!

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        entityManager = EntityManager(scene: self)

        setUpScene()
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {
        entityManager.shootSpell(from: pos)
    }

    private func setUpScene() {
        setUpHUD()
        entityManager.addPlayer()
    }

    private func setUpHUD() {
        let hudNode = HeadsUpDisplayNode(screenSize: self.size)
        addChild(hudNode)
        hudNode.userInputDelegate = entityManager
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        entityManager.spawnEnemy()
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

        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime

        // Update entities
        entityManager.update(deltaTime)

        self.lastUpdateTime = currentTime
    }
}