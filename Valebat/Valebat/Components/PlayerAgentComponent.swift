//
//  PlayerAgentComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 15/3/21.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerAgentComponent: GKAgent2D {
    let entityManager: EntityManager

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }

        position = SIMD2<Float>(x: Float(spriteComponent.node.position.x),
                                y: Float(spriteComponent.node.position.y))
    }
}
