//
//  ObjectiveData.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/4/21.
//

import Foundation

struct ObjectiveData: Codable {
    var objectiveType: String
    var objectiveQuantity: Int

    init(objective: Objective) {
        self.objectiveType = objective.objectiveType.rawValue
        self.objectiveQuantity = objective.objectiveQuantity
    }

    func generateObjective() -> Objective? {
        guard let typeEnum = ObjectiveEnum(rawValue: objectiveType) else {
            return nil
        }
        return Objective(type: typeEnum, quantity: objectiveQuantity)
    }
}
