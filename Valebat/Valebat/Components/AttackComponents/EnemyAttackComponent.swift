//
//  EnemyAttackComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyAttackComponent: BaseComponent {
    let attackCooldown: TimeInterval
    let damageType: BasicType
    let damageValue: CGFloat
    var currentAttackCooldown: TimeInterval = 0.0
    let attackVelocity: CGFloat = 4
    init(attackCooldown: TimeInterval, damageType: BasicType, damageValue: CGFloat) {
        self.attackCooldown = attackCooldown
        self.damageType = damageType
        self.damageValue = damageValue
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        currentAttackCooldown -= seconds
    }
    func attack() {
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        if currentAttackCooldown <= 0 {
            guard let currentPosition = entity?.component(ofType: SpriteComponent.self)?.node.position,
                  let playerPosition = entityManager.lastKnownPlayerPosition else {
                return
            }
            let velocity = (playerPosition - currentPosition).convertToVector().normalized() * attackVelocity
            entityManager.add(EnemyAttackEntity(velocity: velocity,
                                                              position: currentPosition,
                                                              damageType: damageType,
                                                              damageValue: damageValue))
            currentAttackCooldown = attackCooldown
        }
    }
}
