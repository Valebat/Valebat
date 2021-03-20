//
//  ElementPaneTests.swift
//  ValebatTests
//
//  Created by Zhang Yifan on 20/3/21.
//

import XCTest
@testable import Valebat

class ElementPaneTests: XCTestCase {

    func testInit() {
        let elementPane = ElementPane()
        XCTAssert(elementPane.elementQueueArray.count == 0, "elementQueueArray should be initialised with length 0")
        XCTAssert(elementPane.children.count == 2, "number of chile node should be 2")
    }

    func testInit_withCount() {
        let elementPane = ElementPane(count: 2)
        XCTAssert(elementPane.elementQueueArray.count == 0, "elementQueueArray should be initialised with length 0")
        XCTAssert(elementPane.children.count == 2, "number of chile node should be 2")
        XCTAssert(elementPane.arrayCount == 2, "arrayCount should be initialised with 2")
    }

    func testInit_withNegativeCount() {
        let elementPane = ElementPane(count: -1)
        XCTAssert(elementPane.elementQueueArray.count == 0, "elementQueueArray should be initialised with length 0")
        XCTAssert(elementPane.arrayCount == 1, "arrayCount should be initialised with 1 if given count is negative")
    }

    func testSetNewElement_singleElement() {
        let elementPane = ElementPane()
        elementPane.setNewElement(elementType: .water)
        XCTAssert(elementPane.elementQueueArray.count == 1, "element should be added to array")
        XCTAssert(elementPane.elementQueueArray.contains(.water), "water should be added to array")
        elementPane.setNewElement(elementType: .fire)
        XCTAssert(elementPane.elementQueueArray.count == 2, "element should be added to array")
        XCTAssert(elementPane.elementQueueArray.contains(.fire), "water should be added to array")
    }

    func testSetNewElement_exceedCount() {
        let elementPane = ElementPane(count: 3)
        elementPane.setNewElement(elementType: .water)
        elementPane.setNewElement(elementType: .fire)
        elementPane.setNewElement(elementType: .fire)
        XCTAssert(elementPane.elementQueueArray.count == 3, "elements should be added to array")
        elementPane.setNewElement(elementType: .earth)
        XCTAssert(elementPane.elementQueueArray.count == 3, "element array should be capped at count limit")
        XCTAssert(elementPane.elementQueueArray.contains(.earth), "earth should be added to array")
        XCTAssertFalse(elementPane.elementQueueArray.contains(.water), "water should be expelled from array")
    }
    
    func testClearElementQueue() {
        let elementPane = ElementPane(count: 3)
        elementPane.setNewElement(elementType: .water)
        elementPane.setNewElement(elementType: .fire)
        elementPane.setNewElement(elementType: .fire)
        XCTAssert(elementPane.elementQueueArray.count == 3, "elements should be added to array")
        elementPane.clearElementQueue()
        XCTAssert(elementPane.elementQueueArray.count == 0, "elementQueueArray should be empty")
        elementPane.setNewElement(elementType: .water)
        elementPane.setNewElement(elementType: .fire)
        XCTAssert(elementPane.elementQueueArray.count == 2, "elements should be added to array")
    }

}
