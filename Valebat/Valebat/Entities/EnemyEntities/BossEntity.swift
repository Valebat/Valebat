//
//  BossEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BossEntity: BaseInteractableEntity, BaseMapEntity, EnemyProtocol {

    init() {
        let position: CGPoint = CGPoint(x: ViewConstants.sceneWidth * ViewConstants.bossSpawnOffset,
                                        y: ViewConstants.sceneHeight * ViewConstants.bossSpawnOffset)
        let startingHP: CGFloat = 200
        let image = "boss"
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize * 3
        let size = CGSize(width: length, height: length)
        let texture = CustomTexture.initialise(imageNamed: image)
        super.init(texture: texture, size: size, physicsType: .enemy, position: position, isStatic: false)
        addComponent(HealthComponent(health: startingHP))
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
        addComponent(DamageTakerComponent.getDamageTaker(type: .pure))
        addComponent(EnemyMoveComponent(chaseSpeed: 1000, normalSpeed: 200, initialPosition: position))
        addComponent(EnemyAttackComponent(attackCooldown: 1, damageType: .pure, damageValue: 20, attackVelocity: 20))
        addComponent(EnemyStateMachineComponent(attackRange: 500, aggroRange: 1000))
        addComponent(DeathComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
