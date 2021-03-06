//
//  PlayerData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

import GameplayKit

struct PlayerData: Codable {
    var level: Int = 0
    var currentEXP: Int = 0
    var currentPlayerLevel: Int = 0
    var maxHP: Float = 0.0
    var elementType = [String]()
    var elementLevels = [Double]()
    var elementMultipliers = [Double]()

    func assignPlayerStats(gameSession: GameSession) {
        let playerStats = gameSession.playerStats
        gameSession.currentLevel = level
        for index in 0 ..< elementType.count {
            if let type = BasicType.init(rawValue: elementType[index]) {
                playerStats.elementalLevels[type] = elementLevels[index]
                playerStats.elementalMultipliers[type] = CGFloat(elementMultipliers[index])
                playerStats.currentEXP = currentEXP
                playerStats.currentPlayerLevel = currentPlayerLevel
                playerStats.maxHP = CGFloat(maxHP)
            }
        }
    }

    static func convertToPlayerData(gameSession: GameSession) -> PlayerData {
        let playerStats = gameSession.playerStats
        var elementType: [String] = []
        var elementLevels: [Double] = []
        var elementalMultipliers: [Double] = []
        for (type, level) in playerStats.elementalLevels {
            elementType.append(type.rawValue)
            elementLevels.append(level)
        }
        for (_, multiplier) in playerStats.elementalLevels {
            elementalMultipliers.append(multiplier)
        }
        var playerData = PlayerData()
        playerData.level = gameSession.currentLevel
        playerData.elementType = elementType
        playerData.elementLevels = elementLevels
        playerData.elementMultipliers = elementalMultipliers
        playerData.currentEXP = playerStats.currentEXP
        playerData.currentPlayerLevel = playerStats.currentPlayerLevel
        playerData.maxHP = Float(playerStats.maxHP)
        return playerData
    }

    private func convertElementStringToEnum() -> [BasicType] {
        var enumArray: [BasicType] = []
        for typeString in elementType {
            guard let damageType = BasicType(rawValue: typeString) else {
                continue
            }
            enumArray.append(damageType)
        }
        return enumArray
    }
}
