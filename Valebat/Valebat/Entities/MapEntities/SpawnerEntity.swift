//
//  Spawner.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnerEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .spawner

    init(size: CGSize, defaultSpawnTime: Double, position: CGPoint, enemyType: EnemyTypeEnum) {
        super.init()

        let texture = SKTexture(imageNamed: "spawner")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        var spawnComponent: SpawnComponent?
        switch enemyType {
        case .enemy:
            spawnComponent = SpawnComponent(spawnTime: defaultSpawnTime, limit: nil,
                                                at: spriteComponent, enemyType: .enemy)
        case .boss:
            spawnComponent = SpawnComponent(spawnTime: defaultSpawnTime, limit: 1,
                                                at: spriteComponent, enemyType: .boss)
        }
        addComponent(spawnComponent!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
