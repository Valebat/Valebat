//
//  Player.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import GameplayKit

class PlayerEntity: BaseInteractableEntity {
    let powerupManager = PowerupManager()
    var playerModifiers: PlayerModifiers {
        powerupManager.playerModifiers
    }

    weak var userInputInfo: UserInputInfo?

    init(position: CGPoint, playerStats: PlayerStats, playerSpellComp: PlayerAimAndShootComponent,
         entityManager: EntityManager) {
        let texture = CustomTexture.initialise(imageNamed: "character")
        let size = CGSize(width: ViewConstants.playerWidth, height: ViewConstants.playerHeight)
        super.init(texture: texture, size: size, physicsType: .player, position: position, isStatic: false)
        addComponent(DamageTakerComponent(multipliers: playerStats.elementalMultipliers))
        addComponent(HealthComponent(health: playerStats.maxHP))
        addComponent(HealthBarComponent(barWidth: texture.size().width,
                                        barOffset: texture.size().height/2))
        addPlayerComponent(playerComponent: CollectingComponent())
        addPlayerComponent(playerComponent: PlayerMoveComponent(initialPosition: position))
        addPlayerComponent(playerComponent: playerSpellComp)
        let indicatorSize = CGSize(width: 10, height: texture.size().height/2)
        addComponent(AimIndicatorComponent(size: indicatorSize))
        addComponent(LobIndicatorComponent(size: indicatorSize))
        addComponent(PlayerDeathComponent())
    }

    convenience init(position: CGPoint, playerStats: PlayerStats, entityManager: EntityManager) {
        let playerSpellComp = PlayerAimAndShootComponent()
        self.init(position: position, playerStats: playerStats, playerSpellComp: playerSpellComp,
                  entityManager: entityManager)
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
