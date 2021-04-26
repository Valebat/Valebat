//
//  BiomeEnum.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

enum BiomeTypeEnum: String, CaseIterable {
    case easy
    case normal
    case dungeon
    case crazyhouse
    case boss
}

extension BiomeTypeEnum {
    static func getBiomeDataFromType(_ type: BiomeTypeEnum) -> BiomeData {
        switch type {
        case .easy:
            return BiomeData()
                .withDefaultSpawnTime(10.0)
                .withGuaranteedSpawns(object: .spawner, count: 1)
                .withGlobalObjectSpawnChance(4)
                .withObjectiveQuantity(10)
        case .normal:
            return BiomeData()
                .withPossibleObjectiveTypes([.kills, .powerupscollected])
                .withObjectiveQuantity(10)
        case .dungeon:
            return BiomeData()
                .withGlobalObjectSpawnChance(20)
                .withGuaranteedSpawns(object: .spawner, count: 4)
                .withDefaultSpawnTime(4.0)
                .withPossibleObjectiveTypes([.powerupscollected])
                .withObjectiveQuantity(15)
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

    static func getBiomeDataFromTypes(_ types: [BiomeTypeEnum]) -> [BiomeData] {
        return types.map { getBiomeDataFromType($0) }
    }
}
