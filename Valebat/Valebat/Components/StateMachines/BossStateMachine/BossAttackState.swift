//
//  BossAttackState.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BossAttackState: EnemyState {
    var attackRange: CGFloat

    init(for entity: BossEntity, attackRange: CGFloat) {
        self.attackRange = attackRange
        super.init(entity: entity)
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == BossAttackState.self {
            return false
        }
        return true
    }

    override func didEnter(from previousState: GKState?) {
        enemyEntity?.component(ofType: BossAttackComponent.self)?.isAttacking = true
    }

    override func willExit(to nextState: GKState) {
        enemyEntity?.component(ofType: BossAttackComponent.self)?.isAttacking = false
    }

    override func update(deltaTime: TimeInterval) {
        guard let distance = getDistanceFromPlayer(),
              let isAttacking = enemyEntity?.component(ofType: BossAttackComponent.self)?.isCurrentlyAttacking() else {
            return
        }
        if distance > attackRange && !isAttacking {
            stateMachine?.enter(BossMoveState.self)
        }

    }
}
