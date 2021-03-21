//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class PlayerEntity: GKEntity {

    let essenceManager = PlayerEssenceManager()
    override init() {
        super.init()

        let texture = SKTexture(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: texture, size: size), collisionType: .player))
        addComponent(HealthComponent(health: 15))
        addComponent(HealthBarComponent(barWidth: texture.size().width,
                                        barOffset: texture.size().height/2))

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addPlayerComponent(playerComponent: PlayerComponent) {
        addComponent(playerComponent)
        playerComponent.player = self
    }
}
