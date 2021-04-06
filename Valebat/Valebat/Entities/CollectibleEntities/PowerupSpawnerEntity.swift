//
//  PowerupSpawnerEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/4/21.
//

import GameplayKit

class PowerupSpawnerEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .powerupSpawner

    override init() {
        super.init()

        let powerupSpawnerComponent = PowerupSpawnerComponent()
        addComponent(powerupSpawnerComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
