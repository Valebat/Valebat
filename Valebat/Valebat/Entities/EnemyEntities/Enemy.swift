//
//  Enemy.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import GameplayKit

class Enemy: GKEntity {

    override init() {
        super.init()

        let texture = SKTexture(imageNamed: "enemy")
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize
        let size = CGSize(width: length, height: length)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)

        addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width,
                                     barOffset: texture.size().height / 2, health: 15))
        addComponent(MoveComponent(speed: 2))

        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .enemy))
        addComponent(DeathComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
