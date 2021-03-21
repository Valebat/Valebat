//
//  Enemy.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import GameplayKit

class EnemyEntity: GKEntity {

    override init() {
        super.init()

        let texture = SKTexture(imageNamed: "enemy")
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize
        let size = CGSize(width: length, height: length)
        let spriteComponent = SpriteComponent(texture: texture, size: size)
        addComponent(spriteComponent)

        addComponent(HealthComponent(health: 1))
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
        addComponent(MoveComponent(speed: 2))

        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .enemy))
        addComponent(EnemyDeathComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
