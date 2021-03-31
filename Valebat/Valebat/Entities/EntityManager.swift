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
    var player: PlayerEntity?
    var lastKnownPlayerPosition: CGPoint?
    var obstacles: [GKPolygonObstacle] = []
    var elements: [ElementType: Element] = [:]
    // var able = true
    let scene: SKScene
    let gkScene: GKScene
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?
    let spellManager: SpellManager

    lazy var componentSystems: [GKComponentSystem] = {
        let damageSystem = GKComponentSystem(componentClass: DamageComponent.self)
        let spellCastSystem = GKComponentSystem(componentClass: SpellCastComponent.self)
        let deathSystem = GKComponentSystem(componentClass: DeathComponent.self)
        let spawnSystem = GKComponentSystem(componentClass: SpawnComponent.self)
        let enemyAttackSystem = GKComponentSystem(componentClass: EnemyAttackComponent.self)
        let enemyStateSystem = GKComponentSystem(componentClass: EnemyStateMachineComponent.self)
        let timerSystem = GKComponentSystem(componentClass: TimerComponent.self)
        let advanceLevelSystem = GKComponentSystem(componentClass: AdvanceLevelComponent.self)
        return [damageSystem, spellCastSystem, deathSystem, spawnSystem, enemyStateSystem, enemyAttackSystem,
                timerSystem, advanceLevelSystem]
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

    func resetLevel() {
        for entity in self.entities {
            print(entity)
        }
        cleanupLevel()
        addPlayer()
        initialiseMap()
        initialiseGraph()
    }

    func initialiseMap() {
        MapUtil.generateMap(withBiomeType: .normal)

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
        obstacleGraph = graph
        gkScene.addGraph(graph, name: "obstacles")
    }

    func initialseElements() throws {
        try elements.updateValue(Element(with: .water, at: 1.0), forKey: .water)
        try elements.updateValue(Element(with: .fire, at: 1.0), forKey: .fire)
        try elements.updateValue(Element(with: .earth, at: 1.0), forKey: .earth)
    }

    func cleanupLevel() {
        for entity in self.entities {
            remove(entity)
        }
        self.obstacles = []
        self.obstacleGraph = nil
        gkScene.removeGraph("obstacles")
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

    func replaceSprite(_ entity: GKEntity, component: SpriteComponent) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        entity.addComponent(component)
        scene.addChild(component.node)
    }

    func removeComponentOfEntity(_ entity: GKEntity, component: GKComponent) {
        for componentSystem in componentSystems {
            componentSystem.removeComponent(component)
        }
    }

    func addComponentToEntity(_ entity: GKEntity, component: GKComponent) {
        entity.addComponent(component)

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func spawnEnemy(at location: CGPoint) {
       /* if !able {
            return
        }*/
        let enemy = EnemyEntity(position: location)
        add(enemy)
       // able = false
    }

    func addPlayer() {
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        let character = PlayerEntity(position: spawnLocation)
        add(character)
        self.player = character
    }

    func shootSpell(from shootPoint: CGPoint, with velocity: CGVector,
                    using elementsSelected: [Element]) throws {
        let underlyingSpell = try self.spellManager.combine(elements: elementsSelected)
        let spell = SpellEntity(velocity: velocity * ViewConstants.spellVelocityMultiplier,
                                spell: underlyingSpell, position: shootPoint)
        add(spell)
    }

    func updateLastKnownPlayerPosition() {
        if let position = player?.component(ofType: SpriteComponent.self)?.node.position {
            lastKnownPlayerPosition = position
        }
    }
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        updateLastKnownPlayerPosition()
        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        toRemove.removeAll()
    }
}
