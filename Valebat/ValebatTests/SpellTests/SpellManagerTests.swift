//
//  SpellControllerTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 21/3/21.
//

import XCTest

class SpellControllerTests: XCTestCase {

    var spellManager: SpellManager?

    override func setUpWithError() throws {
        spellManager = SpellManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_combineFireAndWater() throws {
        let fireElement = try Element(with: .fire, at: 2)
        let waterElement = try Element(with: .water, at: 3)
        if let combinedSpell = try spellManager?.combineElements(lhs: fireElement, rhs: waterElement) {
            let steamElement = try Element(with: .steam, at: 5)
            XCTAssert(combinedSpell.element == steamElement)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineFireAndEarthReverseOrder() throws {
        let fireElement = try Element(with: .fire, at: 100)
        let earthElement = try Element(with: .earth, at: 3)
        if let combinedSpell = try spellManager?.combineElements(lhs: earthElement, rhs: fireElement) {
            let magmaElement = try Element(with: .magma, at: 103)
            XCTAssert(combinedSpell.element == magmaElement)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineWaterAndEarthReverseOrder() throws {
        let waterElement = try Element(with: .water, at: 10)
        let earthElement = try Element(with: .earth, at: 30)
        if let combinedSpell = try spellManager?.combineElements(lhs: earthElement, rhs: waterElement) {
            let mudElement = try Element(with: .mud, at: 40)
            XCTAssert(combinedSpell.element == mudElement)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineSameElementType() throws {
        let fireElement2 = try Element(with: .fire, at: 2)
        let fireElement3 = try Element(with: .fire, at: 3)
        if let combinedSpell = try spellManager?.combineElements(lhs: fireElement2, rhs: fireElement3) {
            let fireElement5 = try Element(with: .fire, at: 5)
            XCTAssert(combinedSpell.element == fireElement5)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineWithCompositeElementType() throws {
        let waterElement = try Element(with: .water, at: 10)
        let mudElement = try Element(with: .mud, at: 30)
        if let combinedSpell = try spellManager?.combineElements(lhs: mudElement, rhs: waterElement) {
            let genericElement = try Element(with: .generic, at: 40)
            XCTAssert(combinedSpell.element == genericElement)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineWithGeneric() throws {
        let waterElement = try Element(with: .water, at: 10)
        let genericElement = try Element(with: .generic, at: 30)
        if let combinedSpell = try spellManager?.combineElements(lhs: genericElement, rhs: waterElement) {
            let combinedGenericElement = try Element(with: .generic, at: 40)
            XCTAssert(combinedSpell.element == combinedGenericElement)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
