//
//  AdvanceLevelComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class AdvanceLevelComponent: BaseComponent {
    let location: CGPoint
    let replacementSpriteComponent: SpriteComponent

    var isOpen: Bool = false

    init(at location: CGPoint, sprite: SpriteComponent) {
        self.location = location
        self.replacementSpriteComponent = sprite
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func open() {
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        isOpen = true
        
        entityManager.replaceSprite(self.baseEntity!, component: self.replacementSpriteComponent)
    }

    override func update(deltaTime seconds: TimeInterval) {
        if !isOpen { return }

        guard let entityManager = baseEntity?.entityManager,
              let playerPosition = entityManager.lastKnownPlayerPosition else {
            return
        }

        let distance = (playerPosition - self.location).length()
        if distance < ViewConstants.gridSize * GameConstants.stairsSensitivity {
            entityManager.advanceLevel()
        }
    }
}
