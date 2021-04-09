//
//  EntityManager+Level.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import GameplayKit

extension EntityManager {
    func initialiseLevel() {
        immediateAddMapEntities()
        addPlayer()
        initialiseGraph()
        initialiseObservers()
    }

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
        mapManager.goToMap(level: 0, entityManager: self)
        initialiseLevel()
        playing = true
    }

    func advanceLevel() {
        cleanupLevel()
        mapManager.advanceToNextMap(entityManager: self)
        persistenceManager?.saveAllData()
        initialiseLevel()
    }

    func cleanupLevel() {
        for entity in self.entities {
            remove(entity)
        }
        self.obstacles = []
        self.obstacleGraph = nil
        gkScene.removeGraph("obstacles")
        PowerupUtil.resetPowerups()
    }

    func initialiseObservers() {
        for entity in self.entities where entity is ObjectiveObserver {
            guard let observer = entity as? ObjectiveObserver else {
                continue
            }
            self.objectiveManager.registerObserver(observer)
        }
    }
}
