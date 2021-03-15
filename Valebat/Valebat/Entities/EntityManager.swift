//
//  This file is adapted from:
//
//  EntityManager.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()

    var player: Player?
    let scene: SKScene
    let gkScene: GKScene

    lazy var componentSystems: [GKComponentSystem] = {
        return []
    }()

    init(scene: SKScene) {
        self.scene = scene

        let gkScene = GKScene()
        gkScene.rootNode = scene
        self.gkScene = gkScene
    }

    func initialiseMap() {
        let mapEntities: [GKEntity] = MapUtil.getMapEntities(entityManager: self)

        for entity in mapEntities {
            add(entity)
        }

        var obstacles: [GKPolygonObstacle] = []

        for entity in mapEntities {
            var nodes: [SKNode] = []
            nodes.append(entity.component(ofType: SpriteComponent.self)!.node)

            obstacles.append(contentsOf: SKNode.obstacles(fromNodeBounds: nodes))
        }

        print(obstacles.count)

        // TODO replace magic num with 0.5 * player width
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 50.0)

        gkScene.addGraph(graph, name: "obstacles")
    }

    func initialiseGraph() {
    }

    func add(_ entity: GKEntity) {
        entities.insert(entity)

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }

    }

    func remove(_ entity: GKEntity) {

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        toRemove.insert(entity)
        entities.remove(entity)
    }

    func spawnEnemy() {
        let enemy = Enemy(entityManager: self)

        if let spriteComponent = enemy.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position =
                CGPoint(x: CGFloat.random(in: scene.size.width * 0.25 ... scene.size.width * 0.75),
                        y: CGFloat.random(in: scene.size.height * 0.25 ... scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }

        add(enemy)
    }

    func addPlayer() {
        let character = Player(entityManager: self)
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position =
                CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.5)
            spriteComponent.node.zPosition = 2
        }
        add(character)
        self.player = character
    }

    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        toRemove.removeAll()
    }
}

extension EntityManager: UserInputDelegate {
    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat) {
        guard let playerSprite = player?.component(ofType: SpriteComponent.self) else {
            return
        }

        let newPosition = CGPoint(x: playerSprite.node.position.x
                                    + velocity.x * ViewConstants.joystickVelocityMultiplier,
                                  y: playerSprite.node.position.y
                                    + velocity.y * ViewConstants.joystickVelocityMultiplier)

        let graph: GKObstacleGraph = gkScene.graphs["obstacles"] as? GKObstacleGraph<GKGraphNode2D> ?? GKObstacleGraph()
        let startNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(playerSprite.node.position.x),
                                                                          Float(playerSprite.node.position.y)))
        let endNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(newPosition.x),
                                                                        Float(newPosition.y)))

        graph.add([startNode, endNode])
        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: endNode)
        var path: [GKGraphNode2D] = graph.findPath(from: startNode, to: endNode) as? [GKGraphNode2D] ?? []
        graph.remove([startNode, endNode])
        if !path.isEmpty { path.remove(at: 0) }

        let nextPositionInPath: GKGraphNode2D? = path.first
        let nextX: CGFloat = CGFloat(nextPositionInPath?.position.x ?? Float(playerSprite.node.position.x))
        let nextY: CGFloat = CGFloat(nextPositionInPath?.position.y ?? Float(playerSprite.node.position.y))
        let nextPosition: CGPoint = CGPoint(x: nextX, y: nextY)

        playerSprite.node.position = nextPosition
        playerSprite.node.zRotation = angular
    }

    func inputBegan(at location: CGPoint) {

    }
}
