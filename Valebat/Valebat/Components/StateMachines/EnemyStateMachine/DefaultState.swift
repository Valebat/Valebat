//
//  DefaultState.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

// TODO: Functions can be refactored better
class DefaultState: GKState {
    let enemyEntity: BaseEnemyEntity
    let aggroRange: CGFloat
    let speed: CGFloat

    var currentRandomPathCoolDown = GameConstants.randomPathCooldown
    var nextPositions = [CGPoint]()

    init(for entity: BaseEnemyEntity, aggroRange: CGFloat, speed: CGFloat) {
        enemyEntity = entity
        self.aggroRange = aggroRange
        self.speed = speed
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MoveState.self
    }

    override func update(deltaTime: TimeInterval) {
        guard let origin = enemyEntity.getPosition(),
              let playerOrigin = enemyEntity.entityManager?.lastKnownPlayerPosition else {
            return
        }
        let distance = (origin - playerOrigin).length()
        if distance < aggroRange {
            stateMachine?.enter(MoveState.self)
        } else {
            setPathToRandomPosition(deltaTime: deltaTime)
        }
    }

    private func setPathToRandomPosition(deltaTime: TimeInterval) {
        enemyEntity.component(ofType: EnemyMoveComponent.self)?
            .moveToRandomLocationInRadius(deltaTime: deltaTime, with: speed)
    }

}
