//
//  EnemyStateMachineComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyStateMachineComponent: BaseComponent {
    var cachedEnemyMoveComponent: EnemyMoveComponent?
    var stateMachine: GKStateMachine!
    var attackRange: CGFloat
    var aggroRange: CGFloat
    
    init(attackRange: CGFloat, aggroRange: CGFloat) {
        self.aggroRange = aggroRange
        self.attackRange = attackRange
        super.init()
        let defaultState = DefaultState(stateMachineComponent: self)
        let moveState = MoveState(stateMachineComponent: self)
        let attackState = AttackState(stateMachineComponent: self)
        stateMachine = GKStateMachine(states: [defaultState, moveState, attackState])
        stateMachine.enter(DefaultState.self)
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
        if distance < attackRange {
            stateMachine.enter(AttackState.self)
        } else if distance < aggroRange {
            stateMachine.enter(MoveState.self)
        } else {
            stateMachine.enter(DefaultState.self)
        }
        stateMachine.update(deltaTime: seconds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
