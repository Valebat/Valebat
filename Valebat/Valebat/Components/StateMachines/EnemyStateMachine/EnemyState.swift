//
//  EnemyState.swift
//  Valebat
//
//  Created by Sreyans Sipani on 26/4/21.
//

import Foundation
import GameplayKit

class EnemyState: GKState {
    var cachedMoveComponent: EnemyMoveComponent?

    weak var enemyEntity: BaseInteractableEntity?

    init(entity: BaseInteractableEntity) {
        enemyEntity = entity
    }

    func getMoveComponent() -> EnemyMoveComponent? {
        if cachedMoveComponent == nil {
            cachedMoveComponent = enemyEntity?.component(ofType: EnemyMoveComponent.self)
        }
        return cachedMoveComponent
    }

    func getDistanceFromPlayer() -> CGFloat? {
        guard let origin = enemyEntity?.getPosition(),
              let playerOrigin = enemyEntity?.entityManager?.lastKnownPlayerPosition else {
            return nil
        }
        return (origin - playerOrigin).length()
    }
}
