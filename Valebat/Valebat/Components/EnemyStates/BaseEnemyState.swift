//
//  BaseEnemyState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class BaseEnemyState: GKState {
    var stateMachineComponent: EnemyStateMachineComponent
    init(stateMachineComponent: EnemyStateMachineComponent) {
        self.stateMachineComponent = stateMachineComponent
    }

}
