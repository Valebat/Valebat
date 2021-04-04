//
//  LevelData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

// ideally this shld only be saved/generated once, unless player clicks reset. 

class LevelData: Codable {
    var maps: [MapData] = []
    var levelTypes: [String] = []
    var levelLists: [[String]] = []
    var maxLevel: Int = 0

    init(maps: [Map], levelDataMap: [LevelTypeEnum: [BiomeTypeEnum]]) {
        for map in maps {
            self.maps.append(map.convertToMapData())
        }
        for (levelType, levelList) in levelDataMap {
            levelTypes.append(levelType.rawValue)
            levelLists.append(generateStringListFromLevel(levelList))
        }
        maxLevel = MapUtil.maxLevel
    }

    init() {}

    func assignLevelData() {
        setLevelList()
        assignMaps()
        MapUtil.maxLevel = maxLevel
    }

    private func assignMaps() {
        var gameMaps: [Map] = []
        for map in self.maps {
            gameMaps.append(map.generateMap())
        }
        MapUtil.generateMapsFromPersistence(savedMaps: gameMaps)
    }

    private func setLevelList() {
        var levelDataMap: [LevelTypeEnum: [BiomeTypeEnum]] = [:]
        for index in 0..<levelTypes.count {
            guard let levelType = LevelTypeEnum(rawValue: levelTypes[index]) else {
                continue
            }
            let enumLevelList = generateLevelListFromString(levelLists[index])
            levelDataMap[levelType] = enumLevelList
        }
        LevelListUtil.setLevelListFromPersistence(levelDataMap: levelDataMap)
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
