//
//  LevelTypeEnum.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

enum LevelListTypeEnum: String {
    case easy
    case medium
    case hard
    case coop
}

extension LevelListTypeEnum {
    static func getLevelListFromType(_ type: LevelListTypeEnum) -> [BiomeData] {
        switch type {
        case .easy:
            var list: [BiomeData] = []
            list.append(BiomeData()
                            .withObjectiveQuantity(1))
            list.append(BiomeData()
                            .withGuaranteedSpawns(object: .spawner, count: 10))
            list.append(BiomeTypeEnum.getBiomeDataFromType(.boss))
            return list
        case .medium:
            var list: [BiomeData] = []
            for difficultyModifier in 1...9 {
                list.append(BiomeTypeEnum.getBiomeDataFromType(.normal)
                                .withObjectiveQuantity(3 + 2 * difficultyModifier))
            }
            return list
        case .hard:
            var list: [BiomeData] = []
            for difficultyModifier in 1...9 {
                list.append(BiomeData()
                                .withGuaranteedSpawns(object: .spawner, count: difficultyModifier)
                                .withPossibleObjectiveTypes([.kills])
                                .withObjectiveQuantity(5 + 2 * difficultyModifier))
            }
            return list
        case .coop:
            return BiomeTypeEnum.getBiomeDataFromTypes([.easy, .normal, .boss])
        }
    }
}
