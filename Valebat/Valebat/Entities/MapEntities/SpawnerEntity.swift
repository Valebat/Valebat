//
//  Spawner.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnerEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .spawner

    init(size: CGSize, defaultSpawnTime: Double, position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "spawner")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let spawnComponent = SpawnComponent(spawnTime: defaultSpawnTime,
                                            at: spriteComponent)
        addComponent(spawnComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
