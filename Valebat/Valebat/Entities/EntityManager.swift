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

    static private var instance: EntityManager!

    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()

    var player: Player?
    var obstacles: [GKPolygonObstacle] = []
    var elements: [ElementType: Element] = [:]

    let scene: SKScene
    let gkScene: GKScene
    let spellManager: SpellManager

    lazy var componentSystems: [GKComponentSystem] = {
        let damageSystem = GKComponentSystem(componentClass: DamageComponent.self)
        let spellCastSystem = GKComponentSystem(componentClass: SpellCastComponent.self)
        let deathSystem = GKComponentSystem(componentClass: DeathComponent.self)
        let spawnSystem = GKComponentSystem(componentClass: SpawnComponent.self)
        return [damageSystem, spellCastSystem, deathSystem, spawnSystem]
    }()

    static func getInstance() -> EntityManager {
        return instance
    }

    static func getInstance(scene: SKScene) -> EntityManager {
        if instance == nil {
            createInstance(scene: scene)
        }
        return instance
    }

    private static func createInstance(scene: SKScene) {
        if self.instance != nil {
            fatalError()
        }
        self.instance = EntityManager(scene: scene)
    }

    private init(scene: SKScene) {
        self.scene = scene

        let gkScene = GKScene()
        gkScene.rootNode = scene
        self.gkScene = gkScene

        self.spellManager = SpellManager()
    }

    func initialiseMap() {
        MapUtil.generateMap()

        let mapEntities: [GKEntity] = MapUtil.getMapEntities()

        for entity in mapEntities {
            add(entity)
        }
    }

    func initialiseGraph() {
        let mapEntities: [BaseMapEntity] = MapUtil.getMapEntities()

        self.obstacles = []

        for entity in mapEntities where MapObjectConstants.globalDefaultCollidables[entity.objectType] ??
            MapObjectConstants.objectDefaultCollidable {
            var nodes: [SKNode] = []
            nodes.append(entity.component(ofType: SpriteComponent.self)!.node)

            obstacles.append(contentsOf: SKNode.obstacles(fromNodeBounds: nodes))
        }

        let graph: GKObstacleGraph = GKObstacleGraph(obstacles: obstacles,
                                                     bufferRadius: Float(ViewConstants.gridSize / 4))

        for widths in 0...Int(ViewConstants.sceneWidth / ViewConstants.gridSize) {
            for heights in 0...Int(ViewConstants.sceneHeight / ViewConstants.gridSize) {
                let width = Float(widths) * Float(ViewConstants.gridSize)
                let height = Float(heights) * Float(ViewConstants.gridSize)

                let node: GKGraphNode2D = GKGraphNode2D(point: vector_float2(width, height))

                graph.add([node])
            }
        }

        gkScene.addGraph(graph, name: "obstacles")
    }

    func initialseElements() {
        elements.updateValue(Element(with: .water, at: 1.0), forKey: .water)
        elements.updateValue(Element(with: .fire, at: 1.0), forKey: .fire)
        elements.updateValue(Element(with: .earth, at: 1.0), forKey: .earth)
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

    func spawnEnemy(at location: CGPoint) {
        let enemy = Enemy()

        if let spriteComponent = enemy.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = location
            spriteComponent.node.zPosition = 2
        }

        add(enemy)
    }

    func addPlayer() {
        let character = Player()
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position =
                CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                        y: scene.size.height * ViewConstants.playerSpawnOffset)
            spriteComponent.node.zPosition = 2
        }
        add(character)
        self.player = character
    }

    func shootSpell(from shootPoint: CGPoint, with velocity: CGVector,
                    using elementsSelected: Set<Element>) {
        let underlyingSpell = self.spellManager.combine(elements: elementsSelected)
        let spell = SpellEntity(velocity: velocity * ViewConstants.spellVelocityMultiplier, spell: underlyingSpell)
        if let spriteComponent = spell.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = shootPoint
            spriteComponent.node.zPosition = 2
        }
        add(spell)
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

        guard let playerSprite = player?.component(ofType: SpriteComponent.self) else {
            return
        }

        let playerNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(playerSprite.node.position.x),
                                                                           Float(playerSprite.node.position.y)))

        let graph: GKObstacleGraph = gkScene.graphs["obstacles"] as? GKObstacleGraph<GKGraphNode2D> ?? GKObstacleGraph()

        graph.connectUsingObstacles(node: playerNode)

        for entity in entities {
            guard let playerSprite = player?.component(ofType: SpriteComponent.self),
                  let enemySprite = entity.component(ofType: SpriteComponent.self),
                  let enemyMoveComponent = entity.component(ofType: MoveComponent.self)
                  else {
                continue
            }

            let enemyNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(enemySprite.node.position.x),
                                                                              Float(enemySprite.node.position.y)))

            graph.connectUsingObstacles(node: enemyNode)

            var path: [GKGraphNode2D] = graph.findPath(from: enemyNode, to: playerNode) as? [GKGraphNode2D] ?? []
            graph.remove([enemyNode])

            if path.isEmpty {
                var resolved = false
                let directions: [CGPoint] = [CGPoint(x: 1, y: 1), CGPoint(x: -1, y: -1),
                                             CGPoint(x: -1, y: 1), CGPoint(x: 1, y: -1)]
                for idx in 0..<directions.count {
                    if resolved { continue }
                    let newPosition = CGPoint(x: CGFloat(enemySprite.node.position.x) +
                                                directions[idx].x * ViewConstants.baseEnemyEscapeDistance,
                                              y: CGFloat(enemySprite.node.position.y) +
                                                directions[idx].y * ViewConstants.baseEnemyEscapeDistance)

                    let endNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(newPosition.x),
                                                                                    Float(newPosition.y)))
                    graph.connectUsingObstacles(node: endNode)

                    let path: [GKGraphNode2D] = graph.findPath(from: endNode, to: playerNode) as? [GKGraphNode2D] ?? []
                    graph.remove([endNode])

                    guard let nextPositionInPath: GKGraphNode2D = path.first else {
                        continue
                    }

                    let targetX: CGFloat = CGFloat(nextPositionInPath.position.x)
                    let targetY: CGFloat = CGFloat(nextPositionInPath.position.y)
                    let targetPosition: CGPoint = CGPoint(x: targetX, y: targetY)

                    enemySprite.node.position = targetPosition
                    resolved = true
                }
                continue
            }
            if !path.isEmpty { path.remove(at: 0) }

            guard let nextPositionInPath: GKGraphNode2D = path.first else {
                continue
            }

            let targetX: CGFloat = CGFloat(nextPositionInPath.position.x)
            let targetY: CGFloat = CGFloat(nextPositionInPath.position.y)
            let targetPosition: CGPoint = CGPoint(x: targetX, y: targetY)

            let movementVector: CGPoint = targetPosition - enemySprite.node.position
            var actualMovementVector = movementVector
            let moveSpeed: CGFloat = enemyMoveComponent.speed

            if movementVector.length() > moveSpeed {
                let unitMovementVector: CGPoint = movementVector / movementVector.length()
                actualMovementVector = unitMovementVector * moveSpeed
            }
            let nextX = enemySprite.node.position.x + actualMovementVector.x
            let nextY = enemySprite.node.position.y + actualMovementVector.y

            let nextPosition: CGPoint = CGPoint(x: nextX, y: nextY)

            enemySprite.node.position = nextPosition
        }

        graph.remove([playerNode])
    }
}
