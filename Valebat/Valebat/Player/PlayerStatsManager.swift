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
    var elementalEssence: [DamageType: Int]
    var elements: [DamageType: Element]
    var elementalMultipliers: [DamageType: CGFloat]

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
        elementalEssence = [DamageType: Int]()
        elements = [DamageType: Element]()
        elementalMultipliers = [DamageType: CGFloat]()
        do {
            for type in DamageType.allCases {
                elementalEssence[type] = 0
                elements[type] = try Element(with: type.associatedElementType, at: 1.0)
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

    static func addEssence(type: DamageType, amount: Int) {
        getInstance().elementalEssence[type]! += amount
    }
}
