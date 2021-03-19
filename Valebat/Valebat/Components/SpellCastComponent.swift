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

class SpellCastComponent: GKComponent {
    let entityManager = EntityManager.getInstance()
    let velocity: CGVector
    let spellNode: SKNode

    init(spellNode: SKNode, velocity: CGVector) {
        self.spellNode = spellNode
        self.velocity = velocity
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        spellNode.position = CGPoint(x: spellNode.position.x + velocity.dx,
                                     y: spellNode.position.y + velocity.dy)
    }
}
