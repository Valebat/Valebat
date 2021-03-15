//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class Player: GKEntity {

    init(entityManager: EntityManager) {
        super.init()

        let texture = SKTexture(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)

        addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width,
                                     barOffset: texture.size().height/2, health: 15, entityManager: entityManager))

        addComponent(PlayerAgentComponent(entityManager: entityManager))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
