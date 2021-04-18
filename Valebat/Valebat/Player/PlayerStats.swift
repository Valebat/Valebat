//
//  PlayerStatsManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

protocol LevelUPObserver {
    func onLevelUP(newLevel: Int)
}

class PlayerStats {
    var levelUPObservers = [ObjectIdentifier: LevelUPObserver]()
    var maxHP: CGFloat
    var currentEXP: Int
    static let maxHPGainPerLevel: CGFloat = 10.0
    var currentPlayerLevel: Int
    var elementalLevels: [BasicType: Double]
    var elementalMultipliers: [BasicType: CGFloat]

    init() {
        maxHP = 100.0
        currentPlayerLevel = 1
        currentEXP = 0
        elementalMultipliers = [BasicType: CGFloat]()
        elementalLevels = [BasicType: Double]()
        for type in BasicType.allCases {
            elementalLevels[type] = 1.0
            elementalMultipliers[type] = 1
        }
    }

    func reset() {
        maxHP = 100.0
        currentPlayerLevel = 1
        currentEXP = 0
        elementalMultipliers = [BasicType: CGFloat]()
        for type in BasicType.allCases {
            elementalLevels[type] = 1.0
            elementalMultipliers[type] = 1
        }
    }

    func gainEXP(exp: Int) {
        currentEXP += exp
        while currentEXP >= PlayerStats.getEXPPerLevel(level: currentPlayerLevel) {
            currentEXP -= PlayerStats.getEXPPerLevel(level: currentPlayerLevel)
            levelUP()
        }
    }

    func levelUP() {
        currentPlayerLevel += 1
        maxHP += PlayerStats.maxHPGainPerLevel
        for type in BasicType.allCases {
            elementalMultipliers[type] = elementalMultipliers[type] ?? 0 + 1.0
        }
        levelUPObservers.values.forEach({ $0.onLevelUP(newLevel: self.currentPlayerLevel) })
    }

    static func getEXPPerLevel(level: Int) -> Int {
        return 100 + 25 * (level - 1)
    }

    func getElement(type: BasicType) -> Element? {
        do {
            return try Element(with: type, at: elementalLevels[type] ?? 1)
        } catch {
            return nil
        }
    }
}
