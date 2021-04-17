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
    var isHost: Bool?
    var roomManager: RoomManager?

    init(isCoop: Bool, isNewGame: Bool, diffLevel: LevelListTypeEnum) {
        self.isCoop = isCoop
        self.isNewGame = isNewGame
        self.diffLevel = diffLevel
    }

    init(isCoop: Bool, isNewGame: Bool, diffLevel: LevelListTypeEnum, isHost: Bool, roomManager: RoomManager) {
        self.isCoop = isCoop
        self.isNewGame = isNewGame
        self.diffLevel = diffLevel
        self.isHost = isHost
        self.roomManager = roomManager
    }

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
