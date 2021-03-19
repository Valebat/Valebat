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

    var headsUpDisplay: HeadsUpDisplayNode!

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        entityManager = EntityManager.getInstance(scene: self)

        setUpScene()
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {
        
    }

    private func setUpScene() {
        setUpHUD()
        entityManager.addPlayer()
        entityManager.initialiseMap()
        entityManager.initialiseGraph()
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let entityA = contact.bodyA.node?.entity,
              let entityB = contact.bodyB.node?.entity else {
            return
        }
        for component in entityA.components {
            if let contactableComponent = component as? ContactBeginNotifiable {
                contactableComponent.contactDidBegin(with: entityA)
            }
        }
        for component in entityB.components {
            if let contactableComponent = component as? ContactBeginNotifiable {
                contactableComponent.contactDidBegin(with: entityB)
            }
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        guard let entityA = contact.bodyA.node?.entity,
              let entityB = contact.bodyB.node?.entity else {
            return
        }
        for component in entityA.components {
            if let contactableComponent = component as? ContactEndNotifiable {
                contactableComponent.contactDidEnd(with: entityA)
            }
        }
        for component in entityB.components {
            if let contactableComponent = component as? ContactEndNotifiable {
                contactableComponent.contactDidEnd(with: entityB)
            }
        }
    }
}
