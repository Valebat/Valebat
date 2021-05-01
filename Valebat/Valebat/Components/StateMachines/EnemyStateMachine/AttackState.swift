//
//  AttackState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class AttackState: EnemyState {
    let attackRange: CGFloat

    init(for entity: BaseEnemyEntity, attackRange: CGFloat) {
        self.attackRange = attackRange
        super.init(entity: entity)
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MoveState.self
    }

    override func willExit(to nextState: GKState) {
        enemyEntity?.component(ofType: EnemyAttackComponent.self)?.stopAttack()
    }

    override func didEnter(from: GKState?) {
        enemyEntity?.component(ofType: EnemyAttackComponent.self)?.attack()
    }

    override func update(deltaTime: TimeInterval) {
        guard let distance = getDistanceFromPlayer() else {
            return
        }
        if distance > attackRange {
            stateMachine?.enter(MoveState.self)
        }
    }
}
