//
//  MoveState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

class MoveState: EnemyState {

    let aggroRange: CGFloat
    let attackRange: CGFloat
    let speed: CGFloat

    init(for entity: BaseEnemyEntity, attackRange: CGFloat, aggroRange: CGFloat, speed: CGFloat) {
        self.attackRange = attackRange
        self.aggroRange = aggroRange
        self.speed = speed
        super.init(entity: entity)
    }

    // reset the movement when you exit
    override func willExit(to nextState: GKState) {
        getMoveComponent()?.reset()
    }
    override func update(deltaTime: TimeInterval) {
        guard let origin = enemyEntity?.getPosition(),
              let playerOrigin = enemyEntity?.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance < attackRange {
            stateMachine?.enter(AttackState.self)
        } else if distance < aggroRange {
            setPathTowardsPlayer(deltaTime: deltaTime)
        } else {
            stateMachine?.enter(DefaultState.self)
        }
    }

    private func setPathTowardsPlayer(deltaTime: TimeInterval) {
        getMoveComponent()?.moveTowardsPlayer(deltaTime: deltaTime, with: speed)
    }

}
