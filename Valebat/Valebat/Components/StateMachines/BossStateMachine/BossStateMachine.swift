//
//  BossStateMachine.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit
class BossStateMachineComponent: BaseComponent {

    var cachedEnemyMoveComponent: EnemyMoveComponent?
    var stateMachine: GKStateMachine!
    override init() {
        super.init()
        let attackState = BossAttackState(stateMachineComponent: self)
        let moveState = BossMoveState(stateMachineComponent: self)
        stateMachine = GKStateMachine(states: [attackState, moveState])
        stateMachine.enter(BossMoveState.self)
    }
    func getMoveComponent() -> EnemyMoveComponent? {
        if cachedEnemyMoveComponent == nil {
            cachedEnemyMoveComponent = entity?.component(conformingTo: EnemyMoveComponent.self)
        }
        return cachedEnemyMoveComponent
    }
    override func update(deltaTime seconds: TimeInterval) {
        guard let origin = getMoveComponent()?.currentPosition,
              let playerOrigin = baseEntity?.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance > 600.0 {
            stateMachine.enter(BossMoveState.self)
        } else {
            stateMachine.enter(BossAttackState.self)
        }
        stateMachine.update(deltaTime: seconds)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
