//
//  MapUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit
import GameplayKit

class MapUtil {
    static func generateMap() -> Map {
        return TestConstants.testMap
    }

    static func getMapEntities(entityManager: EntityManager) -> [GKEntity] {
        let map: Map = generateMap()
        var entities: [GKEntity] = []

        for object in map.objects {
            var entity: GKEntity

            switch object.type {
            case .rock:
                entity = RockEntity(entityManager: entityManager,
                                    size: CGSize(width: object.xDimension, height: object.xDimension))
            case .wall:
                entity = WallEntity(entityManager: entityManager,
                                    size: CGSize(width: object.xDimension, height: object.xDimension))
            }

            if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position =
                    CGPoint(x: object.position.x,
                            y: object.position.y)
                spriteComponent.node.zPosition = 2
            }

            entities.append(entity)
        }

        return entities
    }
}
