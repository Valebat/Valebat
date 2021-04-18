//
//  AttackState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class AttackState: BaseEnemyState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == AttackState.self {
            return false
        }
        return true
    }
    override func update(deltaTime: TimeInterval) {
        stateMachineComponent.entity?.component(ofType: EnemyAttackComponent.self)?.attack()
    }
}
