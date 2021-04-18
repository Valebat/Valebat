//
//  MapUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit
import GameplayKit

class MapManager {
    var maxLevel = 0
    var map: Map = Map()
    var maps: [Map] = []
    var mapEntities: [BaseMapEntity] = []
    var allMapEntities: [[BaseMapEntity]] = []
    var currentBiome: BiomeTypeEnum = .normal
    let entityManager: EntityManager
    let spawnManager: SpawnManager
    let objectiveManager: ObjectiveManager

    init(entityManager: EntityManager, spawnManager: SpawnManager, objectiveManager: ObjectiveManager) {
        self.entityManager = entityManager
        self.spawnManager = spawnManager
        self.objectiveManager = objectiveManager
    }

    func generateMaps(withLevelType levelType: LevelListTypeEnum) {
        self.map = Map()
        self.maps = []

        let biomeTypes: [BiomeTypeEnum] = LevelListTypeEnum.getLevelListFromType(levelType)
        self.maxLevel = biomeTypes.count

        let borderedMap = addBordersToMap(Map())

        for biomeType in biomeTypes {
            let levelMap = addSpawnsToMap(borderedMap, withBiomeType: biomeType)
            levelMap.setObjective(objectiveManager.createObjectiveFromBiomeType(biomeType))
            maps.append(levelMap)
            allMapEntities.append(getMapEntities(levelMap))
        }

        map = maps[0]
        mapEntities = allMapEntities[0]
        setObjective()
    }

    func generateMapsFromPersistence(savedMaps: [Map], gameSession: GameSession) {
        self.maps = savedMaps
        for savedMap in savedMaps {
            allMapEntities.append(getMapEntities(savedMap))
        }

        let level = gameSession.currentLevel
        self.map = maps[level]
        self.mapEntities = allMapEntities[level]
        setObjective()
    }

    func goToMap(level: Int, gameSession: BaseGameSession) {
        gameSession.currentLevel = level
        map = maps[level]
        mapEntities = allMapEntities[level]
        let resettableEntities = mapEntities.filter({ $0.conforms(to: ResettableEntity.self) })
        resettableEntities.forEach({  ($0 as? ResettableEntity)?.reset() })
        setObjective()
    }

    func advanceToNextMap(gameSession: BaseGameSession) {
        gameSession.currentLevel += 1
        let level = gameSession.currentLevel

        if level < maxLevel {
            map = maps[level]
            mapEntities = allMapEntities[level]
            setObjective()
        } else {
            entityManager.playerWon()
        }
    }

    func setObjective() {
        objectiveManager.setCurrentObjective(map.objective)
    }

    private func addSpawnsToMap(_ map: Map, withBiomeType biomeType: BiomeTypeEnum) -> Map {
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

        let spawnedObjects: [MapObject] = spawnManager.spawnObjects(positions: spawnLocations, withBiomeType: biomeType)

        mapObjects.append(contentsOf: spawnedObjects)

        let resultMap: Map = Map()
        resultMap.addObjects(map.objects)
        resultMap.addObjects(mapObjects)
        return resultMap
    }

    private func addBordersToMap(_ map: Map) -> Map {
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

    private func getMapEntities(_ map: Map) -> [BaseMapEntity] {
        var entities: [BaseMapEntity] = []

        for object in map.objects {
            var entity: BaseMapObjectEntity
            let point = CGPoint(x: object.position.x, y: object.position.y)
            switch object.type {
            case .wall:
                entity = GenericMapEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                          position: point, type: .wall)
            case .rock:
                entity = GenericMapEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                          position: point, type: .rock)
            case .crate:
                entity = GenericMapEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                          position: point, type: .crate)
            case .spawner:
                entity = SpawnerEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                       defaultSpawnTime: BiomeTypeEnum.getBiomeDataFromType(currentBiome).defaultSpawnTime,
                                       position: point, enemyType: .enemy)
            case .bossSpawner:
                entity = SpawnerEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                       defaultSpawnTime: GameConstants.timeBeforeBossSpawns,
                                       position: point, enemyType: .boss)
            case .stairs:
                entity = StairsEntity(size: CGSize(width: object.xDimension, height: object.xDimension),
                                      position: point)
            case .powerupSpawner:
                entity = PowerupSpawnerEntity()
            }
            entities.append(entity)
        }

        return entities
    }

    func getGraph() -> GKGraph {
        var obstacles: [GKPolygonObstacle] = []

        for object in map.objects {
            let obstacle = GKPolygonObstacle(points: MapObjectUtil.getBoundingBoxOfMapObject(object))
            obstacles.append(obstacle)
        }

        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 5.0)

        return graph
    }

    func resetMap() {
        self.map = Map()
    }
}
