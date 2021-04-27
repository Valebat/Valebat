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
        // should be handled by the exit in move states
        // getMoveComponent()?.stopMoving()
        // since attack is a toggle you can just toggle it on upon enter instead of update
        enemyEntity?.component(ofType: EnemyAttackComponent.self)?.attack()
    }

    override func update(deltaTime: TimeInterval) {
        guard let origin = enemyEntity?.getPosition(),
              let playerOrigin = enemyEntity?.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance > attackRange {
            stateMachine?.enter(MoveState.self)
        } else {
            // do not need to call every update
           // enemyEntity?.component(ofType: EnemyAttackComponent.self)?.attack()
        }
    }
}
