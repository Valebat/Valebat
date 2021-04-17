//
//  MapObjectDataTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//
import XCTest

import Foundation

class MapObjectDataTests: XCTestCase {

    var mapObjects: [MapObject] = []

    override func setUpWithError() throws {
        mapObjects = MapObjectFactory.createAllMapObjects()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initFromMapObject() {
        for mapObject in mapObjects {
            let mapObjData = MapObjectData(mapObject: mapObject)
            XCTAssertEqual(mapObjData.collidable, mapObject.collidable)
            XCTAssertEqual(mapObjData.type, mapObject.type.rawValue)
            XCTAssertEqual(mapObjData.xPosition, Double(mapObject.position.x))
            XCTAssertEqual(mapObjData.yPosition, Double(mapObject.position.y))
            XCTAssertEqual(mapObjData.xDimension, mapObject.xDimension)
            XCTAssertEqual(mapObjData.yDimension, mapObject.yDimension)
        }
    }

    func test_generatemapObjectOfAllTypes() {
        for mapObject in mapObjects {
            let mapObjData = MapObjectData(mapObject: mapObject)
            let retrievedMapObject = mapObjData.generateMapObject()
            XCTAssertEqual(retrievedMapObject?.collidable, mapObject.collidable)
            XCTAssertEqual(retrievedMapObject?.type, mapObject.type)
            XCTAssertEqual(retrievedMapObject?.position, mapObject.position)
            XCTAssertEqual(retrievedMapObject?.xDimension, mapObject.xDimension)
            XCTAssertEqual(retrievedMapObject?.yDimension, mapObject.yDimension)
        }
    }

    func test_convertToMapObjectData() {
        for mapObject in mapObjects {
            let mapObjData = MapObjectData.convertToMapObjectData(mapObject)
            XCTAssertEqual(mapObjData.collidable, mapObject.collidable)
            XCTAssertEqual(mapObjData.type, mapObject.type.rawValue)
            XCTAssertEqual(mapObjData.xPosition, Double(mapObject.position.x))
            XCTAssertEqual(mapObjData.yPosition, Double(mapObject.position.y))
            XCTAssertEqual(mapObjData.xDimension, mapObject.xDimension)
            XCTAssertEqual(mapObjData.yDimension, mapObject.yDimension)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
