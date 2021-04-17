//
//  ObjectiveManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

class ObjectiveManager {
    private(set) var currentObjective: Objective = Objective()
    private var observers: [ObjectiveObserver] = []

    var counters: [ObjectiveEnum: Int] = [:]

    func setCurrentObjective(_ objective: Objective) {
        self.currentObjective = objective
        resetCounters()
    }

    private func resetCounters() {
        counters.keys.forEach { counters[$0] = 0 }
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

    func incrementCounter(_ objective: ObjectiveEnum) {
        let currentValue = self.counters[objective] ?? 0
        self.counters[objective] = currentValue + 1
        checkCompletion()
    }

    func checkCompletion() {
        if isObjectiveCompleted() {
            updateObservers()
            clearObservers()
        }
    }

    func isObjectiveCompleted() -> Bool {
        return (self.counters[currentObjective.objectiveType] ?? 0) >= currentObjective.objectiveQuantity
    }

    func remainingQuantity() -> Int {
        return max(currentObjective.objectiveQuantity - (self.counters[currentObjective.objectiveType] ?? 0), 0)
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
