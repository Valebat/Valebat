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

    // Reset movement on exit.
    override func willExit(to nextState: GKState) {
        getMoveComponent()?.reset()
    }
    override func update(deltaTime: TimeInterval) {
        guard let distance = getDistanceFromPlayer() else {
            return
        }
        if distance < attackRange {
            stateMachine?.enter(AttackState.self)
        } else if distance < aggroRange {
            setPathTowardsPlayer(deltaTime: deltaTime)
        } else {
            stateMachine?.enter(IdleState.self)
        }
    }

    private func setPathTowardsPlayer(deltaTime: TimeInterval) {
        getMoveComponent()?.moveTowardsPlayer(deltaTime: deltaTime, with: speed)
    }
}
