//
//  RockEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import GameplayKit

class RockEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .rock

    init(size: CGSize, position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "rock")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .wall))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
