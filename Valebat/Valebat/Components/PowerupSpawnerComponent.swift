//
//  PowerupSpawnerComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/4/21.
//

import GameplayKit

class PowerupSpawnerComponent: GKComponent {
    private let spawnablePositions: [CGPoint]
    private let spawnFrequency: Double = 3.0
    private var clock: Double

    override init() {
        self.spawnablePositions = SpawnUtil.freePositions
        self.clock = spawnFrequency
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        clock -= seconds

        if clock <= 0 {
            clock = spawnFrequency
            if spawnablePositions.count != 0 {
                let randomPosition: CGPoint = spawnablePositions[Int(arc4random()) % Int(spawnablePositions.count)]
                EntityManager.getInstance().add(PowerupEntity(position: randomPosition))
            }
        }
    }
}
