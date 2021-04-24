//
//  MoveState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

class MoveState: GKState {
    let enemyEntity: BaseEnemyEntity
    let aggroRange: CGFloat
    let attackRange: CGFloat
    let speed: CGFloat

    init(for entity: BaseEnemyEntity, attackRange: CGFloat, aggroRange: CGFloat, speed: CGFloat) {
        enemyEntity = entity
        self.attackRange = attackRange
        self.aggroRange = aggroRange
        self.speed = speed
    }

    override func update(deltaTime: TimeInterval) {
        guard let origin = enemyEntity.getPosition(),
              let playerOrigin = enemyEntity.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance < attackRange {
            stateMachine?.enter(AttackState.self)
        } else if distance < aggroRange {
        } else {
            stateMachine?.enter(DefaultState.self)
        }
    }
}
