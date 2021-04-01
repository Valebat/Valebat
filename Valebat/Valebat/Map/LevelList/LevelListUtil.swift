//
//  LevelListUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

class LevelListUtil {
    private static var levelDataMap: [LevelTypeEnum: [BiomeTypeEnum]] = [:]
    private static var isSetup = false

    static func getLevelDataFromType(_ type: LevelTypeEnum) -> [BiomeTypeEnum] {
        if !isSetup {
            let levelListSubclasses: [AnyClass] = Runtime.classes(conformTo: LevelList.Type.self)
            for subclass in levelListSubclasses {
                guard let levelListClass = subclass as? LevelList.Type else {
                    continue
                }
                let levelList = levelListClass.init()
                levelDataMap[levelList.levelType] = levelList.getLevelBiomeData()
            }
            isSetup = true
        }
        return levelDataMap[type] ?? EasyLevelList().levelBiomes
    }

    static func instantiate<T>(class: T.Type) -> T where T: LevelList {
        return T()
    }
}
