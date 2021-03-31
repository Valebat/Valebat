//
//  AdvanceLevelComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class AdvanceLevelComponent: GKComponent {
    let location: CGPoint

    init(at location: CGPoint) {
        self.location = location
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        print("outside delete")
        guard let playerPosition = EntityManager.getInstance().lastKnownPlayerPosition else {
            return
        }
        let distance = (playerPosition - self.location).length()
        print(distance)
        if distance < ViewConstants.gridSize * ViewConstants.stairsSensitivity {
            if let entity = self.entity {
                print("delete")
                EntityManager.getInstance().remove(entity)
            }
            EntityManager.getInstance().resetLevel()
        }
    }
}
