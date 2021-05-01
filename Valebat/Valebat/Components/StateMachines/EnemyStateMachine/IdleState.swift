//
//  DefaultState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

class IdleState: EnemyState {
    let aggroRange: CGFloat
    let speed: CGFloat

    var currentRandomPathCoolDown = GameConstants.randomPathCooldown
    var nextPositions = [CGPoint]()

    init(for entity: BaseEnemyEntity, aggroRange: CGFloat, speed: CGFloat) {
        self.aggroRange = aggroRange
        self.speed = speed
        super.init(entity: entity)
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MoveState.self
    }

    override func update(deltaTime: TimeInterval) {
        guard let distance = getDistanceFromPlayer() else {
            return
        }
        if distance < aggroRange {
            stateMachine?.enter(MoveState.self)
        } else {
            setPathToRandomPosition(deltaTime: deltaTime)
        }
    }

    // reset your movement when you exit
    override func willExit(to nextState: GKState) {
        getMoveComponent()?.reset()
    }
    private func setPathToRandomPosition(deltaTime: TimeInterval) {
        getMoveComponent()?.moveToRandomLocationInRadius(deltaTime: deltaTime, with: speed)
    }

}
