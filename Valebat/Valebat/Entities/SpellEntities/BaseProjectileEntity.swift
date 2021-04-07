//
//  BaseProjectileEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit
class BaseProjectileEntity: BaseInteractableEntity {

    init(textures: [SKTexture], size: CGSize, physicsTexture: SKTexture?,
         physicsType: CollisionType?, position: CGPoint, velocity: CGVector) {
        super.init(textures: textures, size: size, physicsTexture: physicsTexture, physicsType: physicsType, position: position, isStatic: false)
        addComponent(RegularMovementComponent(velocity: velocity, initialPosition: position))
    }

    init(texture: SKTexture, size: CGSize, physicsType: CollisionType?, position: CGPoint, velocity: CGVector) {
        super.init(texture: texture, size: size, physicsType: physicsType, position: position, isStatic: false)
        addComponent(RegularMovementComponent(velocity: velocity, initialPosition: position))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}