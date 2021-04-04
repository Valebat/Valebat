//
//  MapObjectTests.swift
//  ValebatTests
//
//  Created by Jing Lin Shi on 20/3/21.
//

import XCTest
@testable import Valebat

class MapObjectTests: XCTestCase {

    func test_createStaticEntity_hasCorrectType() {
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            XCTAssertEqual(object.type, $0, "Object does not correspond to its type.")
        }
    }

    func test_createStaticEntity_hasCorrectSize() {
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            XCTAssertEqual(object.xDimension,
                           MapObjectConstants.globalDefaultWidths[$0] ?? MapObjectConstants.objectDefaultWidth,
                           "Object initialised to wrong size.")
            XCTAssertEqual(object.yDimension,
                           MapObjectConstants.globalDefaultHeights[$0] ?? MapObjectConstants.objectDefaultHeight,
                           "Object initialised to wrong size.")
        }
    }

    func test_createStaticEntity_hasCorrectCollidableBool() {
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            XCTAssertEqual(object.collidable,
                           MapObjectConstants.globalDefaultCollidables[$0] ??
                            MapObjectConstants.objectDefaultCollidable,
                           "Object initialised to wrong collidable state.")
        }
    }

    func test_createStaticEntity_withScale() {
        let factor: Double = 2.0
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50), scale: factor)
            XCTAssertEqual(object.xDimension, factor *
                            (MapObjectConstants.globalDefaultWidths[$0] ?? MapObjectConstants.objectDefaultWidth),
                           "Object initialised to wrong size.")
            XCTAssertEqual(object.yDimension, factor *
                            (MapObjectConstants.globalDefaultHeights[$0] ?? MapObjectConstants.objectDefaultHeight),
                           "Object initialised to wrong size.")
        }
    }

    func test_createStaticEntity_withCollidableBool() {
        let collidable: Bool = false
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50), collidable: collidable)
            XCTAssertEqual(object.collidable, collidable,
                           "Object initialised to wrong collidable state.")
        }
    }

    func test_createStaticEntity_withScaleAndCollidableBool() {
        let factor: Double = 2.0
        let collidable: Bool = false
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50), scale: factor,
                                         collidable: collidable)
            XCTAssertEqual(object.xDimension, factor *
                            (MapObjectConstants.globalDefaultWidths[$0] ?? MapObjectConstants.objectDefaultWidth),
                           "Object initialised to wrong size.")
            XCTAssertEqual(object.yDimension, factor *
                            (MapObjectConstants.globalDefaultHeights[$0] ?? MapObjectConstants.objectDefaultHeight),
                           "Object initialised to wrong size.")
            XCTAssertEqual(object.collidable, collidable,
                           "Object initialised to wrong collidable state.")
        }
    }

    func test_createStaticEntity_hasFourPoints() {
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            XCTAssertEqual(object.getPoints().count, 4,
                           "Object has incorrect number of points.")
        }
    }

    func test_createStaticEntity_pointDifferenceIsCorrect() {
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            let points: [SIMD2<Float>] = object.getPoints()
            for idx in 0...2 {
                let point1: SIMD2<Float> = points[idx]
                let point2: SIMD2<Float> = points[idx + 1]
                let xDiff: Double = abs(Double(point1.x - point2.x))
                let xMatchesDimension: Bool = (xDiff == 0) || (xDiff == object.xDimension)
                let yDiff: Double = abs(Double(point1.y - point2.y))
                let yMatchesDimension: Bool = (yDiff == 0) || (yDiff == object.yDimension)
                let bothDimesionsZero: Bool = (xDiff == 0) && (yDiff == 0)
                XCTAssertTrue(xMatchesDimension && yMatchesDimension && !bothDimesionsZero,
                               "getPoints returns incorrect dimensions.")
            }
        }
    }

    func test_createIntangibleEntity_isCorrectType() {
        MapObjectEnum.allCases.forEach {
            let object = IntangibleMapObject(type: $0)
            XCTAssertEqual(object.type, $0, "Object does not correspond to its type.")
        }
    }

    func test_createIntangibleEntity_hasNoDimensions() {
        MapObjectEnum.allCases.forEach {
            let object = IntangibleMapObject(type: $0)
            XCTAssertEqual(object.xDimension, 0, "Intangible object should not have dimensions.")
            XCTAssertEqual(object.yDimension, 0, "Intangible object should not have dimensions.")
        }
    }

    func test_createIntangibleEntity_isNotCollidable() {
        MapObjectEnum.allCases.forEach {
            let object = IntangibleMapObject(type: $0)
            XCTAssertEqual(object.collidable, false, "Intangible object should not be collidable.")
        }
    }

}
