//
//  BaseEnemyEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BaseEnemyEntity: BaseInteractableEntity {
    var image: String

    init(position: CGPoint, image: String = "enemy",
         size: CGSize = CGSize(width: ViewConstants.enemyToGridRatio * ViewConstants.gridSize,
                               height: ViewConstants.enemyToGridRatio * ViewConstants.gridSize), startingHP: CGFloat = 10) {
        self.image = image
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, size: size, physicsType: .enemy, position: position, isStatic: false)
        setUpHealth(startingHP: startingHP)
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
        setUpDamageTaker()
        setUpMovement(initialPosition: position)
        setUpAttack()
        setUpStateMachine()
        setUpDeath()
    }

    func setUpDamageTaker() {
        addComponent(DamageTakerComponent())
    }

    func setUpHealth(startingHP: CGFloat) {
        addComponent(HealthComponent(health: startingHP))
    }
    func setUpDeath() {
        addComponent(EnemyDeathComponent())
    }

    func setUpAttack() {
        addComponent(EnemyAttackComponent(attackCooldown: 3.0, damageType: .pure, damageValue: 2))
    }
    func setUpStateMachine() {
        addComponent(EnemyStateMachineComponent())
    }

    func setUpMovement(initialPosition: CGPoint) {
        addComponent(EnemyMoveComponent(chaseSpeed: 120, normalSpeed: 30, initialPosition: initialPosition))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
