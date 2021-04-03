//
//  PlayerStats.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

struct PlayerStats {
    var level: Int = 0
    var elements: [ElementType: Element] = [:]

    func convertToPlayerData() -> PlayerData {
        var elementType: [String] = []
        var elementLevel: [Double] = []
        for (type, element) in elements {
            elementType.append(type.stringName)
            elementLevel.append(element.level)
        }
        var playerData = PlayerData()
        playerData.level = level
        playerData.elementType = elementType
        playerData.elementLevel = elementLevel
        return playerData
    }
}
