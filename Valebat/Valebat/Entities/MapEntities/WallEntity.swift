//
//  WallEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import GameplayKit

class WallEntity: BaseEntity, BaseMapEntity {
    let objectType: MapObjectEnum = .wall

    init(size: CGSize, position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "wall")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .wall))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
