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
    var elements: [BasicType: Element]
    var elementalMultipliers: [BasicType: CGFloat]

    init() {
        maxHP = 100.0
        currentPlayerLevel = 1
        currentEXP = 0
        elements = [BasicType: Element]()
        elementalMultipliers = [BasicType: CGFloat]()
        do {
            for type in BasicType.allCases {
                elements[type] = try Element(with: type, at: 1.0)
                elementalMultipliers[type] = 1
            }
        } catch {
            print("invalid element")
        }
    }

    func reset() {
        maxHP = 15
        currentPlayerLevel = 1
        currentEXP = 0
        elements = [BasicType: Element]()
        elementalMultipliers = [BasicType: CGFloat]()
        do {
            for type in BasicType.allCases {
                elements[type] = try Element(with: type, at: 1.0)
                elementalMultipliers[type] = 1
            }
        } catch {
            print("invalid element")
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
        levelUPObservers.values.forEach({ $0.onLevelUP(newLevel: self.currentPlayerLevel) })
    }

    static func getEXPPerLevel(level: Int) -> Int {
        return 100 + 25 * (level - 1)
    }
}
