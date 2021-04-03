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
        if let combinedSpell = try spellManager?.combine(elements: [fireElement, waterElement]) {
            XCTAssert(combinedSpell.level == 5)
            XCTAssert(combinedSpell is SteamSpell)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineFireAndEarthReverseOrder() throws {
        let fireElement = try Element(with: .fire, at: 100)
        let earthElement = try Element(with: .earth, at: 3)
        if let combinedSpell = try spellManager?.combine(elements: [earthElement, fireElement]) {
            XCTAssert(combinedSpell.level == 103)
            XCTAssert(combinedSpell is MagmaSpell)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineWaterAndEarthReverseOrder() throws {
        let waterElement = try Element(with: .water, at: 10)
        let earthElement = try Element(with: .earth, at: 30)
        if let combinedSpell = try spellManager?.combine(elements: [earthElement, waterElement]) {
            XCTAssert(combinedSpell.level == 40)
            XCTAssert(combinedSpell is MudSpell)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineSameBasicType() throws {
        let fireElement2 = try Element(with: .fire, at: 2)
        let fireElement3 = try Element(with: .fire, at: 3)
        if let combinedSpell = try spellManager?.combine(elements: [fireElement2, fireElement3]) {
            XCTAssert(combinedSpell.level == 5)
            XCTAssert(combinedSpell is SingleElementSpell)
            XCTAssert((combinedSpell as? SingleElementSpell)?.damageType == .fire)
        } else {
            XCTFail("Couldn't combine elements")
        }
    }

    func test_combineWithGeneric() throws {
        let waterElement = try Element(with: .water, at: 10)
        let genericElement = try Element(with: .pure, at: 30)
        if let combinedSpell = try spellManager?.combine(elements: [genericElement, waterElement]) {
            XCTAssert(combinedSpell is GenericSpell)
            XCTAssert(combinedSpell.level == 40)
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
