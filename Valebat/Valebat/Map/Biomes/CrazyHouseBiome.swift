//
//  CrazyHouseBiome.swift
//  Valebat
//
//  Created by Jing Lin Shi on 4/4/21.
//

class CrazyHouseBiome: Biome {
    var biomeType: BiomeTypeEnum = .crazyhouse

    required init() {

    }

    func getBiomeData() -> BiomeData {
        return BiomeData()
            .withGlobalObjectSpawnChance(0)
            .withGuaranteedSpawns(object: .spawner, count: 15)
            .withDefaultSpawnTime(4.0)
    }
}
