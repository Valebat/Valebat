//
//  ObjectiveManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

class ObjectiveManager {
    let currentObjective: Objective = Objective()

    let killCounter: Int = 0
    let powerupCounter: Int = 0

    func isObjectiveCompleted() -> Bool {
        switch currentObjective.objectiveType {
        case .kills:
            return killCounter >= currentObjective.objectiveQuantity
        case .powerupscollected:
            return powerupCounter >= currentObjective.objectiveQuantity
        }
    }

    func remainingQuantity() -> Int {
        switch currentObjective.objectiveType {
        case .kills:
            return max(currentObjective.objectiveQuantity - killCounter, 0)
        case .powerupscollected:
            return max(currentObjective.objectiveQuantity - powerupCounter, 0)
        }
    }

    func getDescription() -> String {
        let remainingQuantityString: String = String(remainingQuantity())
        switch currentObjective.objectiveType {
        case .kills:
            return "Defeat " + remainingQuantityString + " more enemies."
        case .powerupscollected:
            return "Collect " + remainingQuantityString + " more powerups."
        }
    }
}
