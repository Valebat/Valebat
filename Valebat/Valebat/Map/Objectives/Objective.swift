//
//  Objective.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

class Objective {
    let objectiveType: ObjectiveEnum
    let objectiveQuantity: Int

    init(type: ObjectiveEnum, quantity: Int) {
        self.objectiveType = type
        self.objectiveQuantity = quantity > 0 ? quantity : 0
    }

    init() {
        self.objectiveType = .kills
        self.objectiveQuantity = 0
    }
}
