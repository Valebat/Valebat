//
//  AttackState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class AttackState: GKState {
    let enemyEntity: BaseEnemyEntity
    let attackRange: CGFloat

    init(for entity: BaseEnemyEntity, attackRange: CGFloat) {
        enemyEntity = entity
        self.attackRange = attackRange
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MoveState.self
    }

    override func update(deltaTime: TimeInterval) {
        print("in attack state")
        guard let origin = enemyEntity.getPosition(),
              let playerOrigin = enemyEntity.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance > attackRange {
            stateMachine?.enter(MoveState.self)
        }
    }
}
