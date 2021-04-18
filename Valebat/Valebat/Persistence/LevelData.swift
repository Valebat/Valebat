//
//  LevelData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

import SpriteKit

class LevelData: Codable {
    var maps: [MapData] = []
    var maxLevel: Int = 0
    var freePositions: [PositionData] = []

    init(maps: [Map], gameSession: GameSession) {
        for map in maps {
            self.maps.append(MapData.convertToMapData(map))
        }
        maxLevel = gameSession.mapManager.maxLevel
        for pos in gameSession.spawnManager.freePositions {
            let posData = PositionData()
            posData.xPos = Float(pos.x)
            posData.yPos = Float(pos.y)
            freePositions.append(posData)
        }
    }

    init() {}

    func assignLevelData(gameSession: GameSession) {
        var positions: [CGPoint] = []
        for pos in self.freePositions {
            positions.append(CGPoint(x: CGFloat(pos.xPos), y: CGFloat(pos.yPos)))
        }
        gameSession.spawnManager.freePositions = positions
        gameSession.mapManager.maxLevel = maxLevel
        assignMaps(gameSession: gameSession)
    }

    private func assignMaps(gameSession: GameSession) {
        var gameMaps: [Map] = []
        for map in self.maps {
            gameMaps.append(map.generateMap())
        }
        gameSession.mapManager.generateMapsFromPersistence(savedMaps: gameMaps,
                                                           gameSession: gameSession)
    }

    private func generateLevelListFromString(_ stringList: [String]) -> [BiomeTypeEnum] {
        var enumLevelList: [BiomeTypeEnum] = []
        for string in stringList {
            guard let typeEnum = BiomeTypeEnum(rawValue: string) else {
                continue
            }
            enumLevelList.append(typeEnum)
        }
        return enumLevelList
    }

    private func generateStringListFromLevel(_ levelList: [BiomeTypeEnum]) -> [String] {
        var stringList: [String] = []
        for type in levelList {
            stringList.append(type.rawValue)
        }
        return stringList
    }
}
