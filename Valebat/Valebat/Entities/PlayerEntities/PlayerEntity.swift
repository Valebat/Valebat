//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class PlayerEntity: BaseInteractableEntity {

    init(position: CGPoint, playerStats: PlayerStats) {
        let texture = SKTexture(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        super.init(texture: texture, size: size, physicsType: .player, position: position, isStatic: false)
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

    func levelUp() {
        if let health = component(conformingTo: HealthComponent.self) {
            health.fullHealth += PlayerStats.maxHPGainPerLevel
            health.currentHealth += PlayerStats.maxHPGainPerLevel
        }
    }
}
