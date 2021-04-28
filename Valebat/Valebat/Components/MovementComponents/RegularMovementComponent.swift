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

class RegularMovementComponent: SpellMovementComponent {

    override class var identifier: String {
        "straight_line"
    }

    var velocity: CGVector
    required init(velocity: CGVector, initialPosition: CGPoint) {
        self.velocity = velocity
        super.init(velocity: velocity, initialPosition: initialPosition)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        currentPosition = CGPoint(x: currentPosition.x + velocity.dx,
                                     y: currentPosition.y + velocity.dy)
    }

    func stop() {
        self.velocity = CGVector(dx: 0.0, dy: 0.0)
    }
}
