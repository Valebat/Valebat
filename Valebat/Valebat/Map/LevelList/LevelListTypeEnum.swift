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
    static func getLevelListFromType(_ type: LevelListTypeEnum) -> [BiomeTypeEnum] {
        switch type {
        case .easy:
            return [.boss, .normal, .normal, .dungeon, .crazyhouse, .boss]
        case .medium:
            return [.normal, .dungeon, .crazyhouse, .boss, .normal, .boss]
        case .hard:
            return [.normal, .dungeon, .crazyhouse, .dungeon, .boss, .crazyhouse, .crazyhouse, .crazyhouse, .boss]
        case .coop:
            return [.easy]
        }
    }
}
