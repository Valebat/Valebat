//
//  BiomeData.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

class BiomeData {
    var globalObjectSpawnChance: Int = 5
    var globalSpawnChances: [MapObjectEnum: Int] = [.wall: 0,
                                                    .rock: 5,
                                                    .crate: 3 ]

    var globalGuaranteedSpawns: [MapObjectEnum: Int] = [.spawner: 2]

    var defaultSpawnTime: Double = 7.0

    init() {

    }

    func withGlobalObjectSpawnChance(_ globalSpawnChance: Int) -> BiomeData {
        self.globalObjectSpawnChance = min(globalSpawnChance, 255)
        return self
    }

    func withSpecificObjectSpawnChance(object: MapObjectEnum, spawnChance: Int) -> BiomeData {
        self.globalSpawnChances[object] = spawnChance
        return self
    }

    func withGuaranteedSpawns(object: MapObjectEnum, count: Int) -> BiomeData {
        self.globalGuaranteedSpawns[object] = count
        return self
    }

    func withDefaultSpawnTime(_ spawnTime: Double) -> BiomeData {
        self.defaultSpawnTime = spawnTime
        return self
    }
}
