//
//  MapUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit
import GameplayKit

class MapUtil {
    static var maxLevel = 0
    static var map: Map = Map()
    static var maps: [Map] = []
    static var mapEntities: [BaseMapEntity] = []
    static var allMapEntities: [[BaseMapEntity]] = []
    static var currentBiome: BiomeTypeEnum = .normal

    static func generateMaps(withLevelType levelType: LevelTypeEnum) {
        self.map = Map()
        self.maps = []

        let biomeTypes: [BiomeTypeEnum] = LevelListUtil.getLevelDataFromType(levelType)
        self.maxLevel = biomeTypes.count

        let borderedMap = addBordersToMap(Map())

        for biomeType in biomeTypes {
            let levelMap = addSpawnsToMap(borderedMap, withBiomeType: biomeType)
            maps.append(levelMap)
            allMapEntities.append(getMapEntities(levelMap))
        }

        map = maps[0]
        mapEntities = allMapEntities[0]
    }

    static func generateMapsFromPersistence(savedMaps: [Map]) {
        self.maps = savedMaps
        for savedMap in savedMaps {
            allMapEntities.append(getMapEntities(savedMap))
        }

        let level = PlayerStatsManager.getInstance().level
        self.map = maps[level]
        self.mapEntities = allMapEntities[level]
    }

    static func goToMap(level: Int) {
        let playerStats = PlayerStatsManager.getInstance()
        playerStats.level = level
        map = maps[level]
        mapEntities = allMapEntities[level]
    }

    static func advanceToNextMap() {
        let playerStats = PlayerStatsManager.getInstance()
        playerStats.level += 1
        let level = playerStats.level

        if level < maxLevel {
            map = maps[level]
            mapEntities = allMapEntities[level]
        } else {
            // TODO implement player win here
            goToMap(level: 0)
        }
        
        PersistenceManager.getInstance().savePlayerData()
    }

    private static func addSpawnsToMap(_ map: Map, withBiomeType biomeType: BiomeTypeEnum) -> Map {
        currentBiome = biomeType
        var mapObjects: [MapObject] = []

        guard let wallWidth = MapObjectConstants.globalDefaultWidths[.wall],
              let wallHeight = MapObjectConstants.globalDefaultHeights[.wall] else {
            return Map()
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
            }
        }

        let spawnedObjects: [MapObject] = SpawnUtil.spawnObjects(positions: spawnLocations, withBiomeType: biomeType)

        mapObjects.append(contentsOf: spawnedObjects)

        let resultMap: Map = Map()
        resultMap.addObjects(map.objects)
        resultMap.addObjects(mapObjects)
        return resultMap
    }

    private static func addBordersToMap(_ map: Map) -> Map {
        var mapObjects: [MapObject] = []

        guard let wallWidth = MapObjectConstants.globalDefaultWidths[.wall],
              let wallHeight = MapObjectConstants.globalDefaultHeights[.wall] else {
            return Map()
        }

        let numWidth = Int(Double(ViewConstants.sceneWidth) / wallWidth)
        let numHeight = Int(Double(ViewConstants.sceneHeight) / wallHeight)

        for widths in 0...numWidth {
            for heights in 0...numHeight {
                if widths != 0 && widths != numWidth && heights != 0 && heights != numHeight {
                    continue
                }
                let xPosition = Double(widths) * wallWidth
                let yPosition = Double(heights) * wallHeight

                mapObjects.append(StaticMapObject(type: .wall, position: CGPoint(x: xPosition, y: yPosition)))
            }
        }

        let resultMap: Map = Map()
        resultMap.addObjects(map.objects)
        resultMap.addObjects(mapObjects)
        return resultMap
    }

    private static func getMapEntities(_ map: Map) -> [BaseMapEntity] {
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
            case .powerupSpawner:
                entity = PowerupSpawnerEntity()
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

    static func resetMap() {
        self.map = Map()
    }
}
