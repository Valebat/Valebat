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

protocol MoveComponent: GKComponent {
    var currentPosition: CGPoint { get set }
    var orientation: CGFloat? { get set }
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
