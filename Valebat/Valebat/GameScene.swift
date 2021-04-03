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

    var headsUpDisplay: UserInputNode!
    var playerHUDDisplay: PlayerHUD!
    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        entityManager = EntityManager.getInstance(scene: self)

        setUpScene()
        setUpPlayerHUD()
        PlayerStatsManager.initialise()
    }
    func setUpPlayerHUD() {
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
    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    private func setUpScene() {
        setUpHUD()
        entityManager.addPlayer()
        entityManager.initialiseMaps()
        entityManager.initialiseGraph()

        do {
            try entityManager.initialseElements()
        } catch SpellErrors.invalidLevelError {
            print("Wrong level was given")
        } catch SpellErrors.wrongElementTypeError {
            print("Wrong element type was given")
        } catch {
            print("Unexpected error")
        }
    }

    private func setUpHUD() {
        let hudNode = UserInputNode(screenSize: self.size)
        addChild(hudNode)
        hudNode.assignInputDelegate(delegate: entityManager)
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
        playerHUDDisplay.updateHUD()
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        AudioManager.update(seconds: deltaTime)
        // Update entities
        entityManager.update(deltaTime)

        self.lastUpdateTime = currentTime

    }
}
