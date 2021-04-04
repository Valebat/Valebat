//
//  GenericSpell.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 21/3/21.
//

import XCTest

class MagmaSpellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//
    func test_initWithLevel() throws {
        let magmaSpell = try MagmaSpell(at: 2.5)
        XCTAssert(magmaSpell.level == 2.5)
        XCTAssert(magmaSpell.damageTypes.count == 2)
        XCTAssert(magmaSpell.damageTypes.contains(.fire))
        XCTAssert(magmaSpell.damageTypes.contains(.earth))
    }

    func test_initWithInvalidLevel() throws {
        XCTAssertThrowsError(try MagmaSpell(at: -10),
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
