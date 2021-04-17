//
//  CoopEntityManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation
import SpriteKit
import GameplayKit

class CoopEntityManager: EntityManager {
    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        saveSprites()
    }

    private func saveSprites() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveSprites(spriteComponents: spriteComponents)
    }
}
