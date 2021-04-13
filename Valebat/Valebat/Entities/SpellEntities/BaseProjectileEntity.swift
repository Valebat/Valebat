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
        super.init(textures: textures, size: size, physicsTexture: physicsTexture,
                   physicsType: physicsType, position: position, isStatic: false)
        if let baseComponent = RegularMovementComponent(velocity: velocity, initialPosition: position) as? BaseComponent {
            addComponent(baseComponent)
        }
        self.component(ofType: SpriteComponent.self)?.node.zPosition = 3
    }

    init(textures: [SKTexture], size: CGSize, physicsTexture: SKTexture?,
         physicsType: CollisionType?, position: CGPoint, velocity: CGVector,
         movementType: SpellMovementComponent.Type) {
        super.init(textures: textures, size: size, physicsTexture: physicsTexture,
                   physicsType: physicsType, position: position, isStatic: false)
        if let baseComponent = movementType.init(velocity: velocity, initialPosition: position) as? BaseComponent {
            addComponent(baseComponent)
        }
        self.component(ofType: SpriteComponent.self)?.node.zPosition = 3
    }

    init(texture: SKTexture, size: CGSize, physicsType: CollisionType?, position: CGPoint, velocity: CGVector) {
        super.init(texture: texture, size: size, physicsType: physicsType, position: position, isStatic: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
