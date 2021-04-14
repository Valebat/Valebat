//
//  BaseEnemyEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BaseEnemyEntity: BaseInteractableEntity, EnemyProtocol {
    var image: String

    init(enemyData: BasicEnemyData, position: CGPoint) {
        let size = CGSize(width: ViewConstants.enemyToGridRatio * ViewConstants.gridSize,
                          height: ViewConstants.enemyToGridRatio * ViewConstants.gridSize)
        self.image = enemyData.spriteImage
        let texture = CustomTexture.initialise(imageNamed: image)
        super.init(texture: texture, size: size, physicsType: .enemy, position: position, isStatic: false)
        addComponent(HealthComponent(health: enemyData.startingHP))
        addComponent(HealthBarComponent(barWidth: size.width, barOffset: size.height / 2))
        addComponent(DamageTakerComponent.getDamageTaker(type: enemyData.enemyType))
        addComponent(EnemyMoveComponent(chaseSpeed: enemyData.enemyChaseSpeed,
                                        normalSpeed: enemyData.enemyMoveSpeed, initialPosition: position))
        addComponent(EnemyAttackComponent(attackCooldown: enemyData.enemyAttackCooldown,
                                          damageType: enemyData.enemyType,
                                          damageValue: enemyData.attackDamage,
                                          attackVelocity: enemyData.attackVelocity))
        addComponent(EnemyStateMachineComponent(attackRange: enemyData.enemyAttackRange,
                                                aggroRange: enemyData.enemyAggroRange))
        addComponent(EnemyDeathComponent(exp: enemyData.deathEXP))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
