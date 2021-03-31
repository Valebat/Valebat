//
//  BiomeUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.

class BiomeUtil {
    private static var biomeDataMap: [BiomeTypeEnum: BiomeData] = [:]
    private static var isSetup = false

    static func getBiomeDataFromType(_ type: BiomeTypeEnum) -> BiomeData {
        if !isSetup {
            let biomeSubclasses: [AnyClass] = Runtime.classes(conformTo: Biome.Type.self)
            for subclass in biomeSubclasses {
                guard let biomeClass = subclass as? Biome.Type else {
                    continue
                }
                let biome = biomeClass.init()
                biomeDataMap[biome.biomeType] = biome.getBiomeData()
            }
            isSetup = true
        }
        return biomeDataMap[type] ?? NormalBiome().getBiomeData()
    }

    static func instantiate<T>(class: T.Type) -> T where T: Biome {
        return T()
    }
}
