//
//  BossMoveState.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BossMoveState: EnemyState {

    let attackRange: CGFloat
    let speed: CGFloat

    init(for entity: BossEntity, attackRange: CGFloat, speed: CGFloat) {
        self.attackRange = attackRange
        self.speed = speed
        super.init(entity: entity)
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == BossMoveState.self {
            return false
        }
        return true
    }

    override func willExit(to nextState: GKState) {
        getMoveComponent()?.reset()

    }
    override func update(deltaTime: TimeInterval) {
        guard let distance = getDistanceFromPlayer() else {
            return
        }
        if distance < attackRange {
            stateMachine?.enter(BossAttackState.self)
        } else {
            setPathTowardsPlayer(deltaTime: deltaTime)
        }
    }

    private func setPathTowardsPlayer(deltaTime: TimeInterval) {
        getMoveComponent()?.moveTowardsPlayer(deltaTime: deltaTime, with: speed)
    }

}
