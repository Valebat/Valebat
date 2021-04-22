//
//  SpellMovementComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/4/21.
//

import SpriteKit
import GameplayKit

class SpellMovementComponent: MoveComponent {

    class var identifier: String {
        "spell_movement"
    }

    required init(velocity: CGVector, initialPosition: CGPoint) {
        super.init(position: initialPosition, angle: atan2(velocity.dy, velocity.dx))
    }

    init(initialPosition: CGPoint, shootAngle: CGFloat) {
        super.init(position: initialPosition, angle: shootAngle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
