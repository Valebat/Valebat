//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class PlayerEntity: BaseEntity {

    init(position: CGPoint, playerStats: PlayerStats) {
        super.init()

        let texture = SKTexture(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position, isStatic: false)
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: texture, size: size), collisionType: .player))
        addComponent(DamageTakerComponent(multipliers: playerStats.elementalMultipliers))
        addComponent(HealthComponent(health: playerStats.maxHP))
        addComponent(HealthBarComponent(barWidth: texture.size().width,
                                        barOffset: texture.size().height/2))
        addPlayerComponent(playerComponent: CollectingComponent())
        addPlayerComponent(playerComponent: PlayerMoveComponent(initialPosition: position))
        addComponent(PlayerDeathComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addPlayerComponent(playerComponent: PlayerComponent) {
        addComponent(playerComponent as BaseComponent)
        playerComponent.player = self
    }
}
