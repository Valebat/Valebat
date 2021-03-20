//
//  ElementTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 20/3/21.
//

import XCTest

import Foundation

class ElementTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartingLevel() throws {
        let element = Element(with: .water, at: 1)
        XCTAssert(element.level == 1)
    }

    func testValidLevel() throws {
        let element = Element(with: .water, at: 100.5)
        XCTAssert(element.level == 100.5)
    }

    func testPositiveLevelBelowOne() {
//        XCTAssertThrows(expression: Element(with: .water, at: 0.5))
    }
    
    func testNegativeLevel() {
//        XCTAssertThrows(expression: Element(with: .water, at: -1.5))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
