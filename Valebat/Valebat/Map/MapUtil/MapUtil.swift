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
    static var currentBiome: BiomeTypeEnum = .normal

    static func generateMap(withBiomeType biomeType: BiomeTypeEnum) {
        currentBiome = biomeType
        var mapObjects: [MapObject] = []
        guard let wallWidth = MapObjectConstants.globalDefaultWidths[.wall],
              let wallHeight = MapObjectConstants.globalDefaultHeights[.wall] else {
            return
        }

        let numWidth = Int(Double(ViewConstants.sceneWidth) / wallWidth)
        let numHeight = Int(Double(ViewConstants.sceneHeight) / wallHeight)

        var spawnLocations: [CGPoint] = []

        for widths in 0...numWidth {
            for heights in 0...numHeight {
                if widths != 0 && widths != numWidth && heights != 0 && heights != numHeight {
                    let xPosition = Double(widths) * MapObjectConstants.objectDefaultWidth
                    let yPosition = Double(heights) * MapObjectConstants.objectDefaultHeight

                    let position: CGPoint = CGPoint(x: xPosition, y: yPosition)
                    spawnLocations.append(position)

                    continue
                }
                let xPosition = Double(widths) * wallWidth
                let yPosition = Double(heights) * wallHeight

                mapObjects.append(StaticMapObject(type: .wall, position: CGPoint(x: xPosition, y: yPosition)))
            }
        }

        let spawnedObjects: [MapObject] = SpawnUtil.spawnObject(positions: spawnLocations, withBiomeType: biomeType)

        mapObjects.append(contentsOf: spawnedObjects)

        map = Map(withObjects: mapObjects)
    }

    static func getMapEntities() -> [BaseMapEntity] {
        var entities: [BaseMapEntity] = []

        for object in map.objects {
            var entity: BaseMapEntity
            let point = CGPoint(x: object.position.x, y: object.position.y)
            switch object.type {
            case .wall:
                entity = WallEntity(size: CGSize(width: object.xDimension, height: object.xDimension), position: point)
            case .rock:
                entity = RockEntity(size: CGSize(width: object.xDimension, height: object.xDimension), position: point)
            case .crate:
                entity = CrateEntity(size: CGSize(width: object.xDimension, height: object.xDimension), position: point)
            case .spawner:
                entity = SpawnerEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                       defaultSpawnTime: BiomeUtil.getBiomeDataFromType(currentBiome).defaultSpawnTime,
                                       position: point)
            case .stairs:
                entity = StairsEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                      timer: BiomeUtil.getBiomeDataFromType(currentBiome).defaultSpawnTime,
                                      position: point)
            }
            entities.append(entity)
        }

        return entities
    }

    static func getGraph() -> GKGraph {
        var obstacles: [GKPolygonObstacle] = []

        for object in map.objects {
            let obstacle = GKPolygonObstacle(points: object.getPoints())
            obstacles.append(obstacle)
        }

        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 5.0)

        return graph
    }
}