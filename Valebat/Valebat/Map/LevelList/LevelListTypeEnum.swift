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
            return [.normal, .normal, .normal, .dungeon, .crazyhouse]
        case .medium:
            return [.normal, .dungeon, .dungeon, .crazyhouse, .crazyhouse]
        case .hard:
            return [.normal, .dungeon, .crazyhouse, .dungeon, .crazyhouse, .crazyhouse, .crazyhouse]
        }
    }
}
