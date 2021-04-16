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
}

extension LevelListTypeEnum {
    static func getLevelListFromType(_ type: LevelListTypeEnum) -> [BiomeTypeEnum] {
        switch type {
        case .easy:
           // return [.boss]
             return [.normal, .normal, .normal, .dungeon, .crazyhouse, .boss]
        case .medium:
            // return [.boss]
            return [.normal, .dungeon, .crazyhouse, .boss, .normal, .boss]
        case .hard:
            return [.normal, .dungeon, .crazyhouse, .dungeon, .boss, .crazyhouse, .crazyhouse, .crazyhouse, .boss]
        }
    }
}
