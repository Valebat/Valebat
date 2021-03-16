//
//  This file is adapted from:
//
//  SpriteAgent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MoveComponent: GKAgent2D, GKAgentDelegate {
    let entityManager: EntityManager

    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        self.mass = 0.01
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }

        position = SIMD2<Float>(x: Float(spriteComponent.node.position.x),
                                y: Float(spriteComponent.node.position.y))
    }

    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }

        spriteComponent.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        guard let playerAgentComponent = entityManager.player?.component(ofType: PlayerAgentComponent.self) else {
            return
        }

        // Reset behavior
        behavior = MoveBehavior(targetSpeed: maxSpeed, seek: playerAgentComponent, avoid: entityManager.obstacles)
    }
}
