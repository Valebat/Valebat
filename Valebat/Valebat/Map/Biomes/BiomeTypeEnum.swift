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
}

extension BiomeTypeEnum {
    static func getBiomeDataFromType(_ type: BiomeTypeEnum) -> BiomeData {
        switch type {
        case .normal:
            return BiomeData()
        case .dungeon:
            return BiomeData()
                .withGlobalObjectSpawnChance(20)
                .withGuaranteedSpawns(object: .spawner, count: 5)
                .withDefaultSpawnTime(4.0)
        case .crazyhouse:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 15)
                .withDefaultSpawnTime(4.0)
        case .boss:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 0)
                .withIntangibleObjectSpawns(object: .bossSpawner, count: 1)
        }
    }
}
