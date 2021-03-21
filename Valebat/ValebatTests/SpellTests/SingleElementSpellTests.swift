//
//  GenericSpell.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 21/3/21.
//

import XCTest

class SingleElementSpellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initWithElement() throws {
        for type in ElementType.allCases where type.isSingle {
            let element = try Element(with: type, at: 2)
            let spell = try SingleElementSpell(with: element)
            XCTAssert(spell.element == element)
            XCTAssert(spell.damageTypes.count == 1)
            if let damageType = type.associatedDamageType {
                XCTAssert(spell.damageTypes.contains(damageType))
            }
        }

    }

    func test_initWithInvalidElement() throws {
        for type in ElementType.allCases where !type.isSingle {
            let invalidElement = try Element(with: type, at: 2)
            XCTAssertThrowsError(try SingleElementSpell(with: invalidElement),
                                 "Wrong element type error should be thrown") { (error) in
                                    XCTAssertEqual(error as? SpellErrors, SpellErrors.wrongElementTypeError)
            }
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
