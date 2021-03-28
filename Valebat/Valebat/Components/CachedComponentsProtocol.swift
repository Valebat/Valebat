//
//  CachedComponentsProtocol.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit
class CachedEnemyComponents {
    weak var spriteComponent: SpriteComponent?
    weak var moveComponent: EnemyMoveComponent?
}

protocol CachedEnemyComponentsProtocol: GKComponent {
    var cachedEnemyComponents: CachedEnemyComponents { get set }
}

extension CachedEnemyComponentsProtocol {
    func getSpriteComponent() -> SpriteComponent? {
        if cachedEnemyComponents.spriteComponent == nil {
            cachedEnemyComponents.spriteComponent = entity?.component(ofType: SpriteComponent.self)
        }
        return cachedEnemyComponents.spriteComponent
    }

    func getMoveComponent() -> EnemyMoveComponent? {
        if cachedEnemyComponents.moveComponent == nil {
            cachedEnemyComponents.moveComponent = entity?.component(ofType: EnemyMoveComponent.self)
        }
        return cachedEnemyComponents.moveComponent
    }
}
