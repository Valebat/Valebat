//
//  MoveState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

class MoveState: BaseEnemyState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == MoveState.self {
            return false
        }
        return true
    }

    override func update(deltaTime: TimeInterval) {
        stateMachineComponent?.getMoveComponent()?.moveTowardsPlayer(deltaTime: deltaTime)
    }

    override func willExit(to nextState: GKState) {
        stateMachineComponent?.getMoveComponent()?.reset()
    }
}
