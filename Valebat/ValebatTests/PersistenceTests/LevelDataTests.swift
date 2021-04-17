//
//  LevelDataTests.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

import XCTest

import Foundation

class LevelDataTests: XCTestCase {

    var entityManager: EntityManager?
    var gameSession: GameSession?

    override func setUpWithError() throws {
        entityManager = EntityManagerFactory.createEmptyEntityManager()
        gameSession = GameSessionFactory.createGameSession(for: .hard,
                                                           entityManager: entityManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_assignData() {
        let levelData = LevelData(maps: gameSession?.mapManager.maps ?? [],
                                  gameSession: gameSession ?? GameSessionFactory.createEmptyGameSession(entityManager: entityManager))
        let emptyGameSession = GameSessionFactory.createEmptyGameSession(entityManager: entityManager)
        levelData.assignLevelData(gameSession: emptyGameSession)
        for (map, assignedMap) in zip(gameSession?.mapManager.maps ?? [], emptyGameSession.mapManager.maps) {
            XCTAssertEqual(map.objective.objectiveType, assignedMap.objective.objectiveType)
            XCTAssertEqual(map.objective.objectiveQuantity, assignedMap.objective.objectiveQuantity)
            for (mapObject, assignedMapObject) in zip(map.objects, assignedMap.objects) {
                XCTAssert(MapObjectFactory.equals(lhs: mapObject, rhs: assignedMapObject))
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
