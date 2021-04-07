//
//  SpawnComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnComponent: BaseComponent {
    let spawnTime: Double
    var limit: Int?
    let location: SpriteComponent
    var clock: Double
    let enemyType: EnemyTypeEnum

    init(spawnTime: Double, limit: Int?, at location: SpriteComponent, enemyType: EnemyTypeEnum) {
        self.spawnTime = spawnTime
        self.limit = limit
        self.clock = Double(Int(arc4random()) % Int(spawnTime * 10)) / 10
        self.location = location
        self.enemyType = enemyType
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        clock -= seconds

        if clock <= 0 && limit ?? 1 > 0 {
            baseEntity?.entityManager?.spawnEnemy(at: self.location.node.position, enemyType: enemyType)
            if limit != nil {
                limit! -= 1
            }
            clock = spawnTime
        }
    }
}
