//
//  LevelList.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

protocol LevelList {
    var levelType: LevelTypeEnum { get }

    var levelBiomes: [BiomeTypeEnum] { get }

    init()

    func getLevelBiomeData() -> [BiomeTypeEnum]
}

extension LevelList {
    func getLevelBiomeData() -> [BiomeTypeEnum] {
        return levelBiomes
    }
}
