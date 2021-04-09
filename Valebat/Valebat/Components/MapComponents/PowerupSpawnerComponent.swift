//
//  PowerupSpawnerComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/4/21.
//

import GameplayKit

class PowerupSpawnerComponent: BaseComponent {
    private var spawnablePositions: [CGPoint]!
    private var isSetup: Bool = false
    private let spawnFrequency: Double = 3.0
    private var clock: Double

    override init() {
        self.clock = spawnFrequency
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if !isSetup {
            self.spawnablePositions = baseEntity?.entityManager?.spawnManager.freePositions ?? []
            isSetup = true
        }
        clock -= seconds

        if clock <= 0 {
            clock = spawnFrequency
            if spawnablePositions.count != 0 {
                let randomPosition: CGPoint = spawnablePositions[Int(arc4random()) % Int(spawnablePositions.count)]
                baseEntity?.entityManager?.add(PowerupEntity(position: randomPosition))
            }
        }
    }
}
