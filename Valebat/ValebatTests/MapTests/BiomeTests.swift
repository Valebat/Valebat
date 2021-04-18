//
//  MapTests.swift
//  ValebatTests
//
//  Created by Jing Lin Shi on 20/3/21.
//

import XCTest
@testable import Valebat

class BiomeTests: XCTestCase {
    var biomeData = BiomeData()

    override func setUp() {
        biomeData = BiomeData()
    }

    func test_set_withGlobalObjectSpawnChance() {
        biomeData = biomeData
            .withGlobalObjectSpawnChance(10)
        XCTAssertEqual(biomeData.globalObjectSpawnChance, 10,
                       "Failed to set global object spawn chance.")
    }

    func test_set_globalObjectSpawnChance_belowZero_isZero() {
        biomeData = biomeData
            .withGlobalObjectSpawnChance(-1)
        XCTAssertEqual(biomeData.globalObjectSpawnChance, 0,
                       "Global object spawn chance cannot be below 0.")
    }

    func test_set_globalObjectSpawnChance_above255_is255() {
        biomeData = biomeData
            .withGlobalObjectSpawnChance(256)
        XCTAssertEqual(biomeData.globalObjectSpawnChance, 255,
                       "Global object spawn chance cannot be above 255.")
    }

    func test_set_withSpecificObjectSpawnChance() {
        biomeData = biomeData
            .withSpecificObjectSpawnChance(object: .wall, spawnChance: 10)
        XCTAssertEqual(biomeData.globalSpawnChances[.wall], 10,
                       "Failed to set object spawn chance.")
    }

    func test_set_withSpecificObjectSpawnChance_belowZero_isZero() {
        biomeData = biomeData
            .withSpecificObjectSpawnChance(object: .wall, spawnChance: -1)
        XCTAssertEqual(biomeData.globalSpawnChances[.wall], 0,
                       "Object spawn chance cannot be below 0.")
    }

    func test_set_withIntangibleObjectSpawns() {
        biomeData = biomeData
            .withIntangibleObjectSpawns(object: .powerupSpawner, count: 2)
        XCTAssertEqual(biomeData.intangibleObjectSpawns[.powerupSpawner], 2,
                       "Failed to set intangible object spawn count.")
    }

    func test_set_withIntangibleObjectSpawns_belowZero_isZero() {
        biomeData = biomeData
            .withIntangibleObjectSpawns(object: .powerupSpawner, count: -1)
        XCTAssertEqual(biomeData.intangibleObjectSpawns[.powerupSpawner], 0,
                       "Intangible object spawn count cannot be below 0.")
    }

    func test_set_withGuaranteedSpawns() {
        biomeData = biomeData
            .withGuaranteedSpawns(object: .crate, count: 5)
        XCTAssertEqual(biomeData.globalGuaranteedSpawns[.crate], 5,
                       "Failed to set global guaranteed spawns.")
    }

    func test_set_withGuaranteedSpawns_belowZero_isZero() {
        biomeData = biomeData
            .withGuaranteedSpawns(object: .crate, count: -1)
        XCTAssertEqual(biomeData.globalGuaranteedSpawns[.crate], 0,
                       "Global guaranteed spawns cannt be below 0.")
    }

    func test_set_withDefaultSpawnTime() {
        biomeData = biomeData
            .withDefaultSpawnTime(10.0)
        XCTAssertEqual(biomeData.defaultSpawnTime, 10,
                       "Failed to set global default spawn time.")
    }

    func test_set_withDefaultSpawnTime_belowZero_isZero() {
        biomeData = biomeData
            .withDefaultSpawnTime(-1)
        XCTAssertEqual(biomeData.defaultSpawnTime, BiomeData.minimumSpawnTime,
                       "Global default spawn time cannot be below minimum spawn time.")
    }

    func test_set_withProtectedSpawn() {
        biomeData = biomeData
            .withProtectedSpawn(.crate)
        XCTAssertEqual(biomeData.protectedSpawns.contains(.crate), true,
                       "Protected spawn could not be set.")
    }

    func test_set_multipleAttributes() {
        biomeData = biomeData
            .withGlobalObjectSpawnChance(15)
            .withSpecificObjectSpawnChance(object: .wall, spawnChance: 20)
            .withSpecificObjectSpawnChance(object: .rock, spawnChance: 25)
            .withIntangibleObjectSpawns(object: .powerupSpawner, count: 3)
            .withGuaranteedSpawns(object: .crate, count: 6)
            .withGuaranteedSpawns(object: .rock, count: 10)
            .withDefaultSpawnTime(20.0)
        XCTAssertEqual(biomeData.globalObjectSpawnChance, 15,
                       "Failed to set global object spawn chance.")
        XCTAssertEqual(biomeData.globalSpawnChances[.wall], 20,
                       "Failed to set object spawn chance.")
        XCTAssertEqual(biomeData.globalSpawnChances[.rock], 25,
                       "Failed to set object spawn chance.")
        XCTAssertEqual(biomeData.intangibleObjectSpawns[.powerupSpawner], 3,
                       "Failed to set intangible object spawn count.")
        XCTAssertEqual(biomeData.globalGuaranteedSpawns[.crate], 6,
                       "Failed to set global guaranteed spawns.")
        XCTAssertEqual(biomeData.globalGuaranteedSpawns[.rock], 10,
                       "Failed to set global guaranteed spawns.")
        XCTAssertEqual(biomeData.defaultSpawnTime, 20,
                       "Failed to set global default spawn time.")

    }

}
