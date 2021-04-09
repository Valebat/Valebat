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
                .withObjectiveType(.kills)
                .withObjectiveQuantity(3)
        case .dungeon:
            return BiomeData()
                .withGlobalObjectSpawnChance(20)
                .withGuaranteedSpawns(object: .spawner, count: 4)
                .withDefaultSpawnTime(4.0)
                .withObjectiveType(.powerupscollected)
                .withObjectiveQuantity(3)
        case .crazyhouse:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 6)
                .withDefaultSpawnTime(4.0)
                .withObjectiveType(.kills)
                .withObjectiveQuantity(20)
        case .boss:
            return BiomeData()
                .withGlobalObjectSpawnChance(0)
                .withGuaranteedSpawns(object: .spawner, count: 0)
                .withIntangibleObjectSpawns(object: .bossSpawner, count: 1)
                .withObjectiveType(.kills)
                .withObjectiveQuantity(1)
        }
    }
}
