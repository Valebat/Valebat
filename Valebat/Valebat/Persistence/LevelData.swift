//
//  LevelData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

// ideally this shld only be saved/generated once, unless player clicks reset. 

class LevelData: Codable {
    var maps: [MapData] = []
    var maxLevel: Int = 0

    init(maps: [Map]) {
        for map in maps {
            self.maps.append(MapData.convertToMapData(map))
        }
        maxLevel = MapUtil.maxLevel
    }

    init() {}

    func assignLevelData() {
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
