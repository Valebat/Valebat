//
//  MapDataTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

import Foundation
import XCTest

class MapDataTests: XCTestCase {

    var map: Map = Map()

    override func setUpWithError() throws {
        map = Map(withObjects: MapObjectFactory.createAllMapObjects(),
                  withObjective: Objective())
    }

    func test_generateMap() {
        let mapData = MapData(map: map)
        let generatedMap = mapData.generateMap()
        XCTAssertEqual(map.objective.objectiveType, generatedMap.objective.objectiveType)
        XCTAssertEqual(map.objective.objectiveQuantity, generatedMap.objective.objectiveQuantity)
        for (object, generatedObject) in zip(map.objects, generatedMap.objects) {
            XCTAssert(MapObjectFactory.equals(lhs: object, rhs: generatedObject))
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
