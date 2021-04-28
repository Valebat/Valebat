//
//  ViewableEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit

class BaseInteractableEntity: BaseEntity {

    init(texture: SKTexture, size: CGSize, physicsType: CollisionType?, position: CGPoint, isStatic: Bool = true) {
        super.init()
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position, isStatic: isStatic)
        addComponent(spriteComponent)
        if let type = physicsType {
            addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: texture, size: size),
                                          collisionType: type))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getPosition() -> CGPoint? {
        return self.component(ofType: SpriteComponent.self)?.node.position
    }
}
