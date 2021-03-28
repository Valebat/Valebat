//
//  DungeonBiome.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

class DungeonBiome: Biome {
    var biomeType: BiomeTypeEnum = .dungeon

    required init() {

    }

    func getBiomeData() -> BiomeData {
        return BiomeData()
            .withGlobalObjectSpawnChance(20)
            .withGuaranteedSpawns(object: .spawner, count: 5)
            .withDefaultSpawnTime(4.0)
    }
}
