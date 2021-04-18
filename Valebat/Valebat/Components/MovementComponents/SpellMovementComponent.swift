//
//  SpellMovementComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/4/21.
//

import SpriteKit
import GameplayKit

protocol SpellMovementComponent: MoveComponent {
    var currentPosition: CGPoint { get set }
    var orientation: CGFloat? { get set }
    static var identifier: String { get }

    init(velocity: CGVector, initialPosition: CGPoint)
}
