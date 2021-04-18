//
//  Objective.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

import GameplayKit

class Objective {
    let objectiveType: ObjectiveEnum
    let objectiveQuantity: Int

    init(possibleTypes: [ObjectiveEnum], quantity: Int) {
        let objectiveIndex = Int(arc4random()) % possibleTypes.count
        self.objectiveType = possibleTypes[objectiveIndex]
        self.objectiveQuantity = quantity > 0 ? quantity : 0
    }

    init() {
        self.objectiveType = .kills
        self.objectiveQuantity = 0
    }
}
