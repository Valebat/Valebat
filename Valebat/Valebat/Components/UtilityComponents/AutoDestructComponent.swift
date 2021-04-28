//
//  AutoDestructComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/4/21.
//

import GameplayKit

class AutoDestructComponent: BaseComponent {
    var clock: Double

    init(timer: Double) {
        self.clock = timer
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        clock -= seconds
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        if clock <= 0 {
            if let entity = self.baseEntity {
                entityManager.remove(entity)
            }
        }
    }
}
