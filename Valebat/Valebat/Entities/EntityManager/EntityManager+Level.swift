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
        mapManager?.playBGM()
        addPlayer()
        initialiseGraph()
        initialiseObservers()
    }

    func playerDied() {
        playing = false
        if let userInputNode = scene.childNode(withName: "input") as? UserInputNode {
            userInputNode.toggleOutcomeButton(success: false)
        }
    }

    func playerWon() {
        playing = false
        if let userInputNode = scene.childNode(withName: "input") as? UserInputNode {
            userInputNode.toggleOutcomeButton(success: true)
        }
    }

    @objc
    func restart() {
        guard let currentSession = self.currentSession else {
            return
        }
        if let userInputNode = scene.childNode(withName: "input") as? UserInputNode {
            userInputNode.outcomeButton?.goBackDown()
        }
        cleanupLevel()
        currentSession.playerStats.reset()
        mapManager?.goToMap(level: 0, gameSession: currentSession)
        initialiseLevel()
        playing = true
    }

    @objc
    func advanceLevel() {
        guard let currentSession = self.currentSession else {
            return
        }
        cleanupLevel()
        mapManager?.advanceToNextMap(gameSession: currentSession)
        currentSession.persistenceManager?.saveAllData()
        initialiseLevel()
    }

    func cleanupEntities() {
        for entity in self.entities {
            immediateRemove(entity)
        }
    }

    @objc
    func cleanupLevel() {
        cleanupEntities()
        mapManager?.objectiveManager.clearObservers()
        player?.powerupManager.resetPowerups()
        self.obstacles = []
        self.obstacleGraph = nil
        gkScene.removeGraph("obstacles")
    }

    func initialiseObservers() {
        for entity in self.entities where entity is ObjectiveObserver {
            guard let observer = entity as? ObjectiveObserver else {
                continue
            }
            self.currentSession?.objectiveManager.registerObserver(observer)
        }
    }
}
