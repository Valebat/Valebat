//
//  PlayerEssenceComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import Foundation
import GameplayKit

class PlayerEssenceManager {
    var essences: [ElementType: Int]
    init() {
        essences = [ElementType: Int]()
        for element in ElementType.allCases {
            essences[element] = 0
        }
    }

    func addEssence(type: ElementType, amount: Int) {
        essences[type]! += amount
    }
}
