//
//  MapTests.swift
//  ValebatTests
//
//  Created by Jing Lin Shi on 20/3/21.
//

import XCTest
@testable import Valebat

class MapTests: XCTestCase {

    func test_initialiseEmptyMap() {
        let map: Map = Map()
        XCTAssertEqual(map.objects.count, 0, "Initialised map should have no objects.")
    }

    func test_initialiseMapWithObjects() {
        var objects: [StaticMapObject] = []
        MapObjectEnum.allCases.forEach {
            let object = StaticMapObject(type: $0, position: CGPoint(x: 50, y: 50))
            objects.append(object)
        }

        let map: Map = Map(withObjects: objects)
        XCTAssertEqual(map.objects.count, objects.count, "Initialised map should have no objects.")
    }

}
