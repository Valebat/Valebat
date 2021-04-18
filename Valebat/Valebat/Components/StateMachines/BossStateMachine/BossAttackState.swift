//
//  BossAttackState.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit
class BossAttackState: BaseBossState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == BossAttackState.self {
            return false
        }
        return true
    }
    override func didEnter(from previousState: GKState?) {
        // print(String(describing: type(of: previousState)))
    }
    override func update(deltaTime: TimeInterval) {
        stateMachineComponent.entity?.component(ofType: BossAttackComponent.self)?.launchAttack()
    }
    override func willExit(to nextState: GKState) {
    }
}
