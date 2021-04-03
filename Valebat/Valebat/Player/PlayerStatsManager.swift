//
//  PlayerStatsManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import Foundation
import GameplayKit
class PlayerStatsManager {

    static private var instance: PlayerStatsManager!
    var maxHP: CGFloat
    var elementalEssence: [DamageType: Int]
    var elementalLevels: [DamageType: Int]
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
        maxHP = 15
        elementalEssence = [DamageType: Int]()
        elementalLevels = [DamageType: Int]()
        elementalMultipliers = [DamageType: CGFloat]()
        for type in DamageType.allCases {
            elementalEssence[type] = 0
            elementalLevels[type] = 0
            elementalMultipliers[type] = 1
        }
    }

    static func addEssence(type: DamageType, amount: Int) {
        getInstance().elementalEssence[type]! += amount
    }
}
