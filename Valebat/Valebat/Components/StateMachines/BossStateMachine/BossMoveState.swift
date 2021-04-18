//
//  BossMoveState.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BossMoveState: BaseBossState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == BossMoveState.self {
            return false
        }
        return true
    }

    override func update(deltaTime: TimeInterval) {
        stateMachineComponent.getMoveComponent()?.moveTowardsPlayer(deltaTime: deltaTime)
    }

    override func willExit(to nextState: GKState) {
        stateMachineComponent.getMoveComponent()?.reset()
    }
}
