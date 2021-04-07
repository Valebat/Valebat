//
//  BiomeData.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

class BiomeData {
    static let minimumSpawnTime: Double = 1.0

    var globalObjectSpawnChance: Int = 5
    var globalSpawnChances: [MapObjectEnum: Int] = [.wall: 0,
                                                    .rock: 5,
                                                    .crate: 3 ]

    var globalGuaranteedSpawns: [MapObjectEnum: Int] = [.spawner: 2,
                                                        .stairs: 1]

    /// Nothing can spawn with 1 radius of this object.
    /// Only guaranteed spawns can be protected.
    var protectedSpawns: [MapObjectEnum] = [.spawner,
                                            .bossSpawner]

    var intangibleObjectSpawns: [MapObjectEnum: Int] = [.powerupSpawner: 1,
                                                        .bossSpawner: 0]

    var defaultSpawnTime: Double = 6.0
    var defaultStairsTimer: Double = 35.0

    init() {

    }

    func withGlobalObjectSpawnChance(_ globalSpawnChance: Int) -> BiomeData {
        self.globalObjectSpawnChance = max(0, min(globalSpawnChance, 255))
        return self
    }

    func withSpecificObjectSpawnChance(object: MapObjectEnum, spawnChance: Int) -> BiomeData {
        self.globalSpawnChances[object] = max(spawnChance, 0)
        return self
    }

    func withIntangibleObjectSpawns(object: MapObjectEnum, count: Int) -> BiomeData {
        self.intangibleObjectSpawns[object] = max(count, 0)
        return self
    }

    func withGuaranteedSpawns(object: MapObjectEnum, count: Int) -> BiomeData {
        self.globalGuaranteedSpawns[object] = max(count, 0)
        return self
    }

    func withDefaultSpawnTime(_ spawnTime: Double) -> BiomeData {
        self.defaultSpawnTime = max(spawnTime, BiomeData.minimumSpawnTime)
        return self
    }

    func withDefaultStairsTimer(_ timer: Double) -> BiomeData {
        self.defaultStairsTimer = max(timer, 0)
        return self
    }

    /// Currently, only guaranteed spawns can be protected.
    func withProtectedSpawn(_ object: MapObjectEnum) -> BiomeData {
        self.protectedSpawns.append(object)
        return self
    }
}
