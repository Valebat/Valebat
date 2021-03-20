//
//  GenericSpell.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 21/3/21.
//

import XCTest

class SteamSpellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initWithElement() throws {
        let steamElement = try Element(with: .steam, at: 2)
        let steamSpell = try GenericSpell(with: steamElement)
        XCTAssert(steamSpell.element == steamElement)
        XCTAssert(steamSpell.damageTypes.count == 1)
        XCTAssert(steamSpell.damageTypes.contains(.pure))
    }

    func test_initWithInvalidElement() throws {
        let invalidElement = try Element(with: .water, at: 2)
        XCTAssertThrowsError(try GenericSpell(with: invalidElement),
                             "Wrong element type error should be thrown") { (error) in
                                XCTAssertEqual(error as? SpellErrors, SpellErrors.wrongElementTypeError)
        }
    }

    func test_initWithLevel() throws {
        let steamElement = try Element(with: .steam, at: 2.5)
        let steamSpell = try GenericSpell(at: 2.5)
        XCTAssert(steamSpell.element == steamElement)
        XCTAssert(steamSpell.damageTypes.count == 1)
        XCTAssert(steamSpell.damageTypes.contains(.pure))
    }

    func test_initWithInvalidLevel() throws {
        XCTAssertThrowsError(try SteamSpell(at: -10),
                             "Invalid level error should be thrown") { (error) in
                                XCTAssertEqual(error as? SpellErrors, SpellErrors.invalidLevelError)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
