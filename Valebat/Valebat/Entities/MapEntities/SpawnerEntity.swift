//
//  Spawner.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnerEntity: BaseEntity, BaseMapObjectEntity, ResettableEntity {

    let objectType: MapObjectEnum = .spawner
    let spawnTime: Double
    let enemyType: EnemyTypeEnum

    init(size: CGSize, defaultSpawnTime: Double, position: CGPoint, enemyType: EnemyTypeEnum) {
        spawnTime = defaultSpawnTime
        self.enemyType = enemyType

        super.init()
        let texture = CustomTexture.initialise(imageNamed: "spawner")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)
        addSpawnComponent()
    }

    func addSpawnComponent() {
        var spawnComponent: SpawnComponent?
        guard let spriteComponent = self.component(ofType: SpriteComponent.self) else {
            return
        }
        switch enemyType {
        case .enemy:
            spawnComponent = SpawnComponent(spawnTime: spawnTime, limit: nil,
                                                at: spriteComponent, enemyType: .enemy)
        case .boss:
            spawnComponent = SpawnComponent(spawnTime: spawnTime, limit: 1,
                                                at: spriteComponent, enemyType: .boss)
        }
        addComponent(spawnComponent!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reset() {
        self.removeComponent(ofType: SpawnComponent.self)
        addSpawnComponent()
    }
}
