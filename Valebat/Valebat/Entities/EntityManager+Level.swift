//
//  EntityManager+Level.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import GameplayKit

extension EntityManager {
    func advanceLevel() {
        cleanupLevel()
        MapUtil.advanceToNextMap()
        addPlayer()
        let mapEntities: [GKEntity] = MapUtil.getMapEntities()

        for entity in mapEntities {
            add(entity)
        }
    }
}
