//
//  EntityManager+Level.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import GameplayKit

extension EntityManager {

    func playerDied() {
        playing = false
        if let userInputNode = scene.childNode(withName: "input") as? UserInputNode {
            userInputNode.toggleRestartButton()
        }
    }

    func restart() {
        if let userInputNode = scene.childNode(withName: "input") as? UserInputNode {
            userInputNode.toggleRestartButton()
        }
        cleanupLevel()
        PowerupUtil.resetPowerups()
        MapUtil.goToMap(level: 0, entityManager: self)
        addPlayer()
        initialiseGraph()

        let mapEntities: [BaseEntity] = MapUtil.mapEntities
        for entity in mapEntities {
            add(entity)
        }
        playing = true
    }

    func advanceLevel() {
        cleanupLevel()
        PowerupUtil.resetPowerups()
        MapUtil.advanceToNextMap(entityManager: self)
        persistenceManager?.saveAllData()
        addPlayer()
        initialiseGraph()

        let mapEntities: [BaseEntity] = MapUtil.mapEntities
        for entity in mapEntities {
            add(entity)
        }
    }

    func cleanupLevel() {
        for entity in self.entities {
            remove(entity)
        }
        self.obstacles = []
        self.obstacleGraph = nil
        gkScene.removeGraph("obstacles")
    }

}
