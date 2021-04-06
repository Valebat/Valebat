//
//  SpawnComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnComponent: BaseComponent {
    let spawnTime: Double
    let location: SpriteComponent
    var clock: Double

    init(spawnTime: Double, at location: SpriteComponent) {
        self.spawnTime = spawnTime
        self.clock = Double(Int(arc4random()) % Int(spawnTime * 10)) / 10
        self.location = location
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        clock -= seconds

        if clock <= 0 {
            baseEntity?.entityManager?.spawnEnemy(at: self.location.node.position)
            clock = spawnTime
        }
    }
}
