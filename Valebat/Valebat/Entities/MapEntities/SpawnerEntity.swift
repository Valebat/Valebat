//
//  Spawner.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

class SpawnerEntity: GKEntity, BaseMapEntity {
    let objectType: MapObjectEnum = .spawner

    init(size: CGSize) {
        super.init()

        let texture = SKTexture(imageNamed: "spawner")
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: size)
        addComponent(spriteComponent)

        let spawnComponent = SpawnComponent(spawnTime: MapObjectConstants.defaultSpawnTime,
                                            at: spriteComponent)
        addComponent(spawnComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
