//
//  CrateEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class CrateEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .crate

    init(size: CGSize, position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "crate")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .wall))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
