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
        var mapObjects: [MapObject] = []

        let numWidth = Int(Double(ViewConstants.sceneWidth) / MapObjectConstants.wallDefaultWidth)
        let numHeight = Int(Double(ViewConstants.sceneHeight) / MapObjectConstants.wallDefaultHeight)
        for widths in 0...numWidth {
            for heights in 0...numHeight {
                if widths != 0 && widths != numWidth && heights != 0 && heights != numHeight {
                    let rand = Int(arc4random() % 255)
                    if rand < MapObjectConstants.rockSpawnChance {
                        let xPosition = Double(widths) * MapObjectConstants.rockDefaultWidth
                        let yPosition = Double(heights) * MapObjectConstants.rockDefaultHeight

                        mapObjects.append(Rock(position: CGPoint(x: xPosition, y: yPosition)))
                    }

                    continue
                }
                let xPosition = Double(widths) * MapObjectConstants.wallDefaultWidth
                let yPosition = Double(heights) * MapObjectConstants.wallDefaultHeight

                mapObjects.append(Wall(position: CGPoint(x: xPosition, y: yPosition)))
            }
        }

        map = Map(withObjects: mapObjects)
    }

    static func getMapEntities() -> [GKEntity] {
        var entities: [GKEntity] = []

        for object in map.objects {
            var entity: GKEntity

            switch object.type {
            case .rock:
                entity = RockEntity(size: CGSize(width: object.xDimension, height: object.xDimension))
            case .wall:
                entity = WallEntity(size: CGSize(width: object.xDimension, height: object.xDimension))
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
