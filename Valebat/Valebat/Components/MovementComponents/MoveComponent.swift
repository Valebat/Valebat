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

class MoveComponent: BaseComponent {
    var currentPosition: CGPoint
    var orientation: CGFloat?

    init(position: CGPoint) {
        self.currentPosition = position
        super.init()
    }

    init(position: CGPoint, angle: CGFloat) {
        self.currentPosition = position
        self.orientation = angle
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol MovementCachable: GKComponent {
    var cachedMoveComponent: MoveComponent? { get set }
}
extension MovementCachable {
    func getMovementComponent() -> MoveComponent? {
        if cachedMoveComponent == nil {
            cachedMoveComponent = entity?.component(conformingTo: MoveComponent.self)
        }
        return cachedMoveComponent
    }
    func getCurrentPosition() -> CGPoint? {
        getMovementComponent()?.currentPosition
    }
}
