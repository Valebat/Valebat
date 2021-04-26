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

    weak var enemyEntity: BaseEnemyEntity?

    init(entity: BaseEnemyEntity) {
        enemyEntity = entity
    }

    func getMoveComponent() -> EnemyMoveComponent? {
        if cachedMoveComponent == nil {
            cachedMoveComponent = enemyEntity?.component(ofType: EnemyMoveComponent.self)
        }
        return cachedMoveComponent
    }

}
