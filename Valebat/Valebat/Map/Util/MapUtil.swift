//
//  MapUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit
import GameplayKit

class MapUtil {
    static var map: Map = TestConstants.testMap

    static func generateMap() {
        map = TestConstants.testMap
    }

    static func getMapEntities(entityManager: EntityManager) -> [GKEntity] {
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

    static func getGraph() -> GKGraph {
        var obstacles: [GKPolygonObstacle] = []

        for object in map.objects {
            let obstacle = GKPolygonObstacle(points: object.getPoints())
            print(object.getPoints())
            obstacles.append(obstacle)
        }

        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 5.0)

        return graph
    }
}
