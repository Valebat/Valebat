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

class RegularMovementComponent: BaseComponent, MoveComponent {

    var velocity: CGVector
    var currentPosition: CGPoint
    var orientation: CGFloat?
    init(velocity: CGVector, initialPosition: CGPoint) {
        orientation = atan2(velocity.dy, velocity.dx)
        self.velocity = velocity
        self.currentPosition = initialPosition
        super.init()
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
