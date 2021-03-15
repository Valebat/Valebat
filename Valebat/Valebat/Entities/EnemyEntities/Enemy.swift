//
//  Enemy.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import GameplayKit

class Enemy: GKEntity {

    init(entityManager: EntityManager) {
        super.init()

        let texture = SKTexture(imageNamed: "test")
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)

        addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width,
                                     barOffset: texture.size().height/2, health: 15, entityManager: entityManager))
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3),
                                   entityManager: entityManager))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
