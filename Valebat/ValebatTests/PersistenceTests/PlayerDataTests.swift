//
//  PlayerDataTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

import XCTest

import Foundation

class PlayerDataTests: XCTestCase {

    var entityManager: EntityManager?
    var gameSession: GameSession?
    var samplePlayerData: PlayerData?
    var defaultPlayerData: PlayerData?

    override func setUpWithError() throws {
        entityManager = EntityManagerFactory.createEmptyEntityManager()
        gameSession = GameSessionFactory.createEmptyGameSession(entityManager: entityManager)
        defaultPlayerData = PlayerData(level: 0, elementType: BasicType.allCases.map({ $0.rawValue }),
                                       elementLevels: BasicType.allCases.map({ _ in 1.0 }),
                                       elementMultipliers: BasicType.allCases.map({ _ in 1 }))
        samplePlayerData = PlayerData(level: 3, elementType: ["water", "fire"],
                                      elementLevels: [1.0, 2.5], elementMultipliers: [0.7, 2.3])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_assignStats() {
        let session = gameSession ?? GameSessionFactory.createEmptyGameSession(entityManager: entityManager)
        samplePlayerData?.assignPlayerStats(gameSession: session)
        XCTAssertEqual(session.currentLevel, samplePlayerData?.level)
        for type in BasicType.allCases {
            let sessionLevel = session.playerStats.elementalLevels[type]
            let sessionMultiplier = session.playerStats.elementalMultipliers[type]
            guard let sampleIndex = samplePlayerData?.elementType.firstIndex(of: type.rawValue) else {
                continue
            }
            let sampleLevel = samplePlayerData?.elementLevels[sampleIndex]
            let sampleMultiplier = CGFloat(samplePlayerData?.elementMultipliers[sampleIndex] ?? 0.0)
            XCTAssertEqual(sessionLevel, sampleLevel)
            XCTAssertEqual(sessionMultiplier, sampleMultiplier)
        }
    }

    func test_convert() {
        let session = gameSession ?? GameSessionFactory.createEmptyGameSession(entityManager: entityManager)
        let convertedData = PlayerData.convertToPlayerData(gameSession: session)
        for (idx, type) in convertedData.elementType.enumerated() {
            XCTAssert(defaultPlayerData?.elementType.contains(type) ?? false)
            guard let defIdx = defaultPlayerData?.elementType.firstIndex(of: type) else {
                XCTFail("Type not in both")
                return
            }
            XCTAssertEqual(convertedData.elementLevels[idx], defaultPlayerData?.elementLevels[defIdx])
            XCTAssertEqual(convertedData.elementMultipliers[idx], defaultPlayerData?.elementMultipliers[defIdx])
        }
        XCTAssertEqual(convertedData.level, defaultPlayerData?.level)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
