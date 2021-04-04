//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class PlayerEntity: GKEntity {

    init(position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position, isStatic: false)
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: texture, size: size), collisionType: .player))
        addComponent(DamageTakerComponent(multipliers: PlayerStatsManager.getInstance().elementalMultipliers))
        addComponent(HealthComponent(health: PlayerStatsManager.getInstance().maxHP))
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
        addComponent(playerComponent)
        playerComponent.player = self
    }
}
