//
//  BaseBossState.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BaseBossState: GKState {
    weak var stateMachineComponent: BossStateMachineComponent?

    init(stateMachineComponent: BossStateMachineComponent) {
        self.stateMachineComponent = stateMachineComponent
    }

}
