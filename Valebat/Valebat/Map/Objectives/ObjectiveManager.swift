//
//  ObjectiveManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

class ObjectiveManager {
    private(set) var currentObjective: Objective = Objective()
    private var observers: [ObjectiveObserver] = []

    var killCounter: Int = 0
    var powerupCounter: Int = 0

    func setCurrentObjective(_ objective: Objective) {
        self.currentObjective = objective
        resetCounters()
    }

    private func resetCounters() {
        self.killCounter = 0
        self.powerupCounter = 0
    }

    func registerObserver(_ observer: ObjectiveObserver) {
        self.observers.append(observer)
    }

    func updateObservers() {
        observers.forEach { $0.objectiveUpdate() }
    }

    func clearObservers() {
        self.observers = []
    }

    func incrementKillCounter() {
        self.killCounter += 1
        checkCompletion()
    }

    func incrementPowerupCounter() {
        self.powerupCounter += 1
        checkCompletion()
    }

    func checkCompletion() {
        if isObjectiveCompleted() {
            updateObservers()
            clearObservers()
        }
    }

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
