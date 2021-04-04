//
//  PlayerStatsManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

class PlayerStatsManager {

    static private var instance: PlayerStatsManager!
    var level: Int
    var maxHP: CGFloat
    var elementalEssence: [BasicType: Int]
    var elements: [BasicType: Element]
    var elementalMultipliers: [BasicType: CGFloat]

    static func getInstance() -> PlayerStatsManager {
        if instance == nil {
            initialise()
        }
        return instance
    }

    static func initialise() {
        self.instance = PlayerStatsManager()
    }

    init() {
        level = 0
        maxHP = 15
        elementalEssence = [BasicType: Int]()
        elements = [BasicType: Element]()
        elementalMultipliers = [BasicType: CGFloat]()
        do {
            for type in BasicType.allCases {
                elementalEssence[type] = 0
                elements[type] = try Element(with: type, at: 1.0)
                elementalMultipliers[type] = 1
            }
        } catch {
            print("invalid element")
        }
    }

    func convertToPlayerData() -> PlayerData {
        var elementType: [String] = []
        var elementLevel: [Double] = []
        for (type, element) in elements {
            elementType.append(type.rawValue)
            elementLevel.append(element.level)
        }
        var playerData = PlayerData()
        playerData.level = level
        playerData.elementType = elementType
        playerData.elementLevel = elementLevel
        return playerData
    }

    static func addEssence(type: BasicType, amount: Int) {
        getInstance().elementalEssence[type]! += amount
    }
}
