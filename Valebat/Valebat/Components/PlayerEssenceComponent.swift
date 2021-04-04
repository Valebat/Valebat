//
//  PlayerEssenceComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit

class PlayerEssenceManager {
    var essences: [BasicType: Int]
    init() {
        essences = [BasicType: Int]()
        for element in BasicType.allCases {
            essences[element] = 0
        }
    }

    func addEssence(type: BasicType, amount: Int) {
        essences[type]! += amount
    }
}
