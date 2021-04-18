//
//  ObjectiveDataTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//
import XCTest

import Foundation

class ObjectiveDataTests: XCTestCase {

    var objectives: [Objective] = []

    override func setUpWithError() throws {
        for type in ObjectiveEnum.allCases {
            objectives.append(Objective(possibleTypes: [type], quantity: 1))
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_allObjectiveTypes() {
        for objective in objectives {
            let objData = ObjectiveData(objective: objective)
            XCTAssert(objData.objectiveType == objective.objectiveType.rawValue)
            XCTAssert(objData.objectiveQuantity == 1)
        }
    }

    func test_negativeQuantity() {
        let objective = Objective(possibleTypes: [.kills], quantity: -1) // With +ve quantity
        let objData = ObjectiveData(objective: objective)
        XCTAssert(objData.objectiveQuantity == 0)
    }

    func test_defaultObjective() {
        let objective = Objective() // With +ve quantity
        let objData = ObjectiveData(objective: objective)
        XCTAssert(objData.objectiveType == "kills")
        XCTAssert(objData.objectiveQuantity == 0)
    }

    func test_generateObjectiveOfAllTypes() {
        for objective in objectives {
            let objData = ObjectiveData(objective: objective)
            let retrievedObjective = objData.generateObjective()
            XCTAssert(retrievedObjective?.objectiveType == objective.objectiveType)
            XCTAssert(retrievedObjective?.objectiveQuantity == objective.objectiveQuantity)
        }
    }

    func test_generateNegativeObjective() {
        let objective = Objective(possibleTypes: [.kills], quantity: -25) // With +ve quantity
        let objData = ObjectiveData(objective: objective)
        let retrievedObjective = objData.generateObjective()
        XCTAssert(retrievedObjective?.objectiveQuantity == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
