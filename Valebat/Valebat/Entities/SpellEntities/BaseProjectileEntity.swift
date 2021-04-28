//
//  BaseProjectileEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit
class BaseProjectileEntity: BaseInteractableEntity {

    init(texture: SKTexture, size: CGSize, physicsType: CollisionType?, position: CGPoint,
         velocity: CGVector, movementType: SpellMovementComponent.Type = RegularMovementComponent.self) {
        super.init(texture: texture, size: size, physicsType: physicsType, position: position, isStatic: false)
        addComponent(movementType.init(velocity: velocity, initialPosition: position))
        self.component(ofType: SpriteComponent.self)?.node.zPosition = 3
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
