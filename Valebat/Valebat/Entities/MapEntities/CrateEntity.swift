//
//  CrateEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class CrateEntity: GKEntity, BaseMapEntity {
    let objectType: MapObjectEnum = .crate

    init(size: CGSize) {
        super.init()

        let texture = SKTexture(imageNamed: "crate")
        let spriteComponent = SpriteComponent(texture: texture, size: size)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .wall))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
