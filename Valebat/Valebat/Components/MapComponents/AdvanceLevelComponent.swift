//
//  AdvanceLevelComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class AdvanceLevelComponent: BaseComponent {
    let location: CGPoint

    init(at location: CGPoint) {
        self.location = location
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        guard let playerPosition = entityManager.lastKnownPlayerPosition else {
            return
        }
        let distance = (playerPosition - self.location).length()
        if distance < ViewConstants.gridSize * ViewConstants.stairsSensitivity {
            if let entity = self.baseEntity {
                entityManager.remove(entity)
            }
            entityManager.advanceLevel()
        }
    }
}
