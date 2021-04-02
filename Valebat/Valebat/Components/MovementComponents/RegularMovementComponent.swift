//
//  This file is adapted from:
//
//  SpriteAgent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class RegularMovementComponent: GKComponent, MoveComponent {
    let entityManager = EntityManager.getInstance()
    let velocity: CGVector
    let spellNode: SKNode
    var currentPosition: CGPoint
    init(spellNode: SKNode, velocity: CGVector, initialPosition: CGPoint) {
        self.spellNode = spellNode
        self.spellNode.zRotation = atan2(velocity.dy, velocity.dx)
        self.velocity = velocity
        self.currentPosition = initialPosition
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        currentPosition = CGPoint(x: spellNode.position.x + velocity.dx,
                                     y: spellNode.position.y + velocity.dy)
    }
}
