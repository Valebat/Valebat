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
            return BiomeTypeEnum.getBiomeDataFromTypes([.normal, .normal, .normal,
                                                       .dungeon, .crazyhouse, .boss])
        case .medium:
            return BiomeTypeEnum.getBiomeDataFromTypes([.normal, .dungeon, .crazyhouse,
                                                        .boss, .normal, .boss])
        case .hard:
            var list: [BiomeData] = []
            for spawners in 1...9 {
                list.append(BiomeData()
                                .withGuaranteedSpawns(object: .spawner, count: spawners)
                                .withPossibleObjectiveTypes([.kills])
                                .withObjectiveQuantity(1))
            }
            return list
        case .coop:
            return BiomeTypeEnum.getBiomeDataFromTypes([.easy, .normal, .boss])
        }
    }
}
