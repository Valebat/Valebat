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
    }
    
    func restart() {
        cleanupLevel()
        MapUtil.goToMap(level: 0)
        addPlayer()
        initialiseGraph()

        let mapEntities: [GKEntity] = MapUtil.mapEntities
        for entity in mapEntities {
            add(entity)
        }
        playing = true
    }

    func advanceLevel() {
        cleanupLevel()
        MapUtil.advanceToNextMap()
        addPlayer()
        initialiseGraph()

        let mapEntities: [GKEntity] = MapUtil.mapEntities
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
