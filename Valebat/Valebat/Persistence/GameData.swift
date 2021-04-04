//
//  GameData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

class GameData: Codable {
    var levelData: LevelData
    var playerData: PlayerData

    init(levelData: LevelData, playerData: PlayerData) {
        self.levelData = levelData
        self.playerData = playerData
    }
}
