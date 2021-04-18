//
//  BiomeEnum.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

enum BiomeTypeEnum: String, CaseIterable {
    case normal
    case dungeon
    case crazyhouse
    case boss
    case easy
}

extension BiomeTypeEnum {
    static func getBiomeDataFromType(_ type: BiomeTypeEnum) -> BiomeData {
        switch type {
        case .easy:
            return BiomeData()
                .withDefaultSpawnTime(10.0)
                .withGlobalObjectSpawnChance(0)
                .withIntangibleObjectSpawns(object: .spawner, count: 1)
        case .normal:
            return BiomeData()
                .withPossibleObjectiveTypes([.kills, .powerupscollected])
                .withObjectiveQuantity(3)
        case .dungeon:
            return BiomeData()
                .withGlobalObjectSpawnChance(20)
                .withGuaranteedSpawns(object: .spawner, count: 4)
                .withDefaultSpawnTime(4.0)
                .withPossibleObjectiveTypes([.powerupscollected])
                .withObjectiveQuantity(5)
        case .crazyhouse:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 6)
                .withDefaultSpawnTime(4.0)
                .withPossibleObjectiveTypes([.kills])
                .withObjectiveQuantity(20)
        case .boss:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 0)
                .withIntangibleObjectSpawns(object: .bossSpawner, count: 1)
                .withPossibleObjectiveTypes([.kills])
                .withObjectiveQuantity(1)
        }
    }
}
