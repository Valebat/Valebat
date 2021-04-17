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
        XCTAssert(elementPane.children.count == 2, "number of chile node should be 2")
    }

    func testInit_withCount() {
        let elementPane = ElementPane(count: 2)
        XCTAssert(elementPane.children.count == 2, "number of chile node should be 2")
        XCTAssert(elementPane.arrayCount == 2, "arrayCount should be initialised with 2")
    }

    func testInit_withNegativeCount() {
        let elementPane = ElementPane(count: -1)
        XCTAssert(elementPane.arrayCount == 1, "arrayCount should be initialised with 1 if given count is negative")
    }

}
