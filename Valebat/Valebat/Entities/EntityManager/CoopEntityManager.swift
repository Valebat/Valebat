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
    let isHost: Bool

    init(scene: GameScene, isHost: Bool) {
        self.isHost = isHost
        super.init(scene: scene)
    }

    override func update(_ deltaTime: CFTimeInterval) {
        super.update(deltaTime)

        if self.isHost {
            saveSprites()
        } else {
            loadSprites()
        }
    }

    private func saveSprites() {
        let spriteComponents = spriteSystem.components
        currentSession?.coopManager?.saveSprites(spriteComponents: spriteComponents)
    }

    private func loadSprites() {
        currentSession?.coopManager?.loadSprites()
    }
}
