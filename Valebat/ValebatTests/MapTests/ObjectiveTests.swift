//
//  ObjectiveTests.swift
//  ValebatTests
//
//  Created by Jing Lin Shi on 17/4/21.
//

import XCTest
@testable import Valebat

class ObjectiveTests: XCTestCase {

    func test_initialiseObjective() {
        let objective = Objective(possibleTypes: [.kills], quantity: 10)

        XCTAssertEqual(objective.objectiveType, .kills, "Objective initialised incorrectly.")
        XCTAssertEqual(objective.objectiveQuantity, 10, "Objective initialised incorrectly.")
    }

    func test_initialiseObjective_quantityBelowZero() {
        let objective = Objective(possibleTypes: [.kills], quantity: -1)

        XCTAssertEqual(objective.objectiveType, .kills, "Objective initialised incorrectly.")
        XCTAssertEqual(objective.objectiveQuantity, 0, "Objective initialised incorrectly.")
    }

    func test_initialiseObjectiveManager() {
        let objectiveManager = ObjectiveManager()

        XCTAssertEqual(objectiveManager.counters[.kills] ?? 0, 0, "Objective manager initialised incorrectly.")
    }

    func test_incrementObjectiveManagerCounter() {
        let objectiveManager = ObjectiveManager()
        objectiveManager.incrementCounter(.kills)

        XCTAssertEqual(objectiveManager.counters[.kills] ?? 0, 1, "Objective manager failed to increment.")
    }

    func test_incrementObjectiveManagerCounter_multipleIncrements() {
        let objectiveManager = ObjectiveManager()
        for _ in 1...5 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.counters[.kills] ?? 0, 5, "Objective manager failed to increment.")
    }

    func test_setObjective() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)

        XCTAssertEqual(objectiveManager.currentObjective.objectiveType, .kills,
                       "Set objective failed.")
        XCTAssertEqual(objectiveManager.currentObjective.objectiveQuantity, 10,
                       "Set objective failed.")
    }

    func test_setObjective_increment_objectiveNotCompleted() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...9 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.isObjectiveCompleted(), false,
                       "Objective completed too early.")
    }

    func test_setObjective_increment_otherCounter_doesNothing() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...20 {
            objectiveManager.incrementCounter(.powerupscollected)
        }

        XCTAssertEqual(objectiveManager.isObjectiveCompleted(), false,
                       "Wrong objective type completed.")
    }

    func test_setObjective_increment_objectiveCompleted() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...10 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.isObjectiveCompleted(), true,
                       "Objective failed to complete.")
    }

    func test_setNewObjective_resetsCounters() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...9 {
            objectiveManager.incrementCounter(.kills)
        }
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...9 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.isObjectiveCompleted(), false,
                       "Objective completed too early.")
    }

    func test_remainingQuantity1() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)

        XCTAssertEqual(objectiveManager.remainingQuantity(), 10,
                       "Remaining quantity is incorrect.")
    }

    func test_remainingQuantity2() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...9 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.remainingQuantity(), 1,
                       "Remaining quantity is incorrect.")
    }

    func test_remainingQuantity3() {
        let objectiveManager = ObjectiveManager()
        let objective = Objective(possibleTypes: [.kills], quantity: 10)
        objectiveManager.setCurrentObjective(objective)
        for _ in 1...10 {
            objectiveManager.incrementCounter(.kills)
        }

        XCTAssertEqual(objectiveManager.remainingQuantity(), 0,
                       "Remaining quantity is incorrect.")
    }

}
