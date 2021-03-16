//
//  This file is adapted from:
//
//  EntityManager.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()

    var player: Player?
    let scene: SKScene

    lazy var componentSystems: [GKComponentSystem] = {
        return []
    }()

    init(scene: SKScene) {
        self.scene = scene
    }

    func add(_ entity: GKEntity) {
        entities.insert(entity)

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }

    }

    func remove(_ entity: GKEntity) {

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        toRemove.insert(entity)
        entities.remove(entity)
    }

    func spawnEnemy() {
        let enemy = Enemy(entityManager: self)

        if let spriteComponent = enemy.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position =
                CGPoint(x: CGFloat.random(in: scene.size.width * 0.25 ... scene.size.width * 0.75),
                        y: CGFloat.random(in: scene.size.height * 0.25 ... scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }

        add(enemy)
    }

    func addPlayer() {
        let character = Player(entityManager: self)
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position =
                CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.5)
            spriteComponent.node.zPosition = 2
        }
        add(character)
        self.player = character
    }

    func shootSpell(from touchPoint: CGPoint) {
        let spell = SpellEntity(entityManager: self)
        if let spriteComponent = spell.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = touchPoint
            spriteComponent.node.zPosition = 2
        }
        add(spell)
    }

    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        toRemove.removeAll()
    }
}

extension EntityManager: UserInputDelegate {
    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat) {
        guard let playerSprite = player?.component(ofType: SpriteComponent.self) else {
            return
        }

        let newPosition = CGPoint(x: playerSprite.node.position.x
                                    + velocity.x * ViewConstants.joystickVelocityMultiplier,
                                  y: playerSprite.node.position.y
                                    + velocity.y * ViewConstants.joystickVelocityMultiplier)

        playerSprite.node.position = newPosition
        playerSprite.node.zRotation = angular
    }

    func inputBegan(at location: CGPoint) {
    }

}
