//
//  CrateEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class CrateEntity: GKEntity {

    init(size: CGSize) {
        super.init()

        let texture = SKTexture(imageNamed: "crate")
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody.affectedByGravity = false
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .wall))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
