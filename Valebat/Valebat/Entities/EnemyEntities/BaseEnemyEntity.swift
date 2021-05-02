//
//  BaseEnemyEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BaseEnemyEntity: BaseInteractableEntity {
    let image: String
    var stateMachine: GKStateMachine?

    init(enemyData: BasicEnemyData, position: CGPoint) {
        let size = CGSize(width: ViewConstants.enemyToGridRatio * ViewConstants.gridSize,
                          height: ViewConstants.enemyToGridRatio * ViewConstants.gridSize)
        self.image = enemyData.spriteImage
        let texture = CustomTexture.initialise(imageNamed: image)
        super.init(texture: texture, size: size, physicsType: .enemy, position: position, isStatic: false)
        addComponent(HealthComponent(health: enemyData.startingHP))
        addComponent(HealthBarComponent(barWidth: size.width, barOffset: size.height / 2))
        addComponent(DamageTakerComponent.getDamageTaker(type: enemyData.enemyType))
        addComponent(EnemyMoveComponent(initialPosition: position))
        addComponent(EnemyAttackComponent(attackCooldown: enemyData.enemyAttackCooldown,
                                          damageType: enemyData.enemyType,
                                          damageValue: enemyData.attackDamage,
                                          attackVelocity: enemyData.attackVelocity))
        addComponent(EnemyDeathComponent(exp: enemyData.deathEXP))
        setUpStateMachine(enemyData: enemyData)
    }

    private func setUpStateMachine(enemyData: BasicEnemyData) {
        let defaultState = IdleState(for: self, aggroRange: enemyData.enemyAggroRange,
                                        speed: enemyData.enemyMoveSpeed)
        let moveState = MoveState(for: self, attackRange: enemyData.enemyAttackRange,
                                  aggroRange: enemyData.enemyAggroRange, speed: enemyData.enemyChaseSpeed)
        let attackState = AttackState(for: self, attackRange: enemyData.enemyAttackRange)
        self.stateMachine = GKStateMachine(states: [defaultState, moveState, attackState])
        self.stateMachine?.enter(IdleState.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        self.stateMachine?.update(deltaTime: seconds)
    }
}
