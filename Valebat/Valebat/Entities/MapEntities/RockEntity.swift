//
//  RockEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import GameplayKit

class RockEntity: GKEntity {

    init(entityManager: EntityManager, size: CGSize) {
        super.init()

        let texture = SKTexture(imageNamed: "rock")
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
