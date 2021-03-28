//
//  BaseBiome.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

class NormalBiome: Biome {
    var biomeType: BiomeTypeEnum = .normal

    required init() {

    }

    func getBiomeData() -> BiomeData {
        return BiomeData()
    }
}
