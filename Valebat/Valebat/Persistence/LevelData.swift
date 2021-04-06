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

    init(maps: [Map]) {
        for map in maps {
            self.maps.append(MapData.convertToMapData(map))
        }
        maxLevel = MapUtil.maxLevel
        for pos in SpawnUtil.freePositions {
            let posData = PositionData()
            posData.xPos = Float(pos.x)
            posData.yPos = Float(pos.y)
            freePositions.append(posData)
        }
    }

    init() {}

    func assignLevelData() {
        var positions: [CGPoint] = []
        for pos in self.freePositions {
            positions.append(CGPoint(x: CGFloat(pos.xPos), y: CGFloat(pos.yPos)))
        }
        SpawnUtil.freePositions = positions
        MapUtil.maxLevel = maxLevel
        assignMaps()

    }

    private func assignMaps() {
        var gameMaps: [Map] = []
        for map in self.maps {
            gameMaps.append(map.generateMap())
        }
        MapUtil.generateMapsFromPersistence(savedMaps: gameMaps)
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
