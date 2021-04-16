//
//  UserConfig.swift
//  Valebat
//
//  Created by Zhang Yifan on 11/4/21.
//

struct UserConfig {
    var isCoop: Bool
    var isNewGame: Bool
    var diffLevel: LevelListTypeEnum

    static func coopGame(diffLevel: LevelListTypeEnum) -> UserConfig {
        self.init(isCoop: true, isNewGame: false, diffLevel: diffLevel)
    }

    static func newGame(diffLevel: LevelListTypeEnum) -> UserConfig {
        self.init(isCoop: false, isNewGame: true, diffLevel: diffLevel)
    }

    static func resumeGame() -> UserConfig {
        self.init(isCoop: false, isNewGame: false, diffLevel: LevelListTypeEnum.medium)
    }

}
