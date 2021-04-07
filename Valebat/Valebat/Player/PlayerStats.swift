//
//  PlayerStatsManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

class PlayerStats {

    var maxHP: CGFloat
    var elementalEssence: [BasicType: Int]
    var elements: [BasicType: Element]
    var elementalMultipliers: [BasicType: CGFloat]

    init() {
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

    func addEssence(type: BasicType, amount: Int) {
        elementalEssence[type]! += amount
    }
}
