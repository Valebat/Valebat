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
    var toAdd = Set<GKEntity>()
    var player: PlayerEntity?
    var currentSession: GameSession
    var lastKnownPlayerPosition: CGPoint?
    var obstacles: [GKPolygonObstacle] = []
    let scene: SKScene
    let gkScene: GKScene
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?
    let spellManager: SpellManager
    let objectiveManager: ObjectiveManager
    var playing: Bool = true

    weak var persistenceManager: PersistenceManager?

    lazy var componentSystems: [GKComponentSystem] = {
        let physicsSystem = GKComponentSystem(componentClass: PhysicsComponent.self)
        let regularMovementSystem = GKComponentSystem(componentClass: RegularMovementComponent.self)
        let projectileMovementSystem = GKComponentSystem(componentClass: ProjectileMotionComponent.self)
        let spawnSystem = GKComponentSystem(componentClass: SpawnComponent.self)
        let enemyAttackSystem = GKComponentSystem(componentClass: EnemyAttackComponent.self)
        let spriteSystem = GKComponentSystem(componentClass: SpriteComponent.self)
        let enemyStateSystem = GKComponentSystem(componentClass: EnemyStateMachineComponent.self)
        let timerSystem = GKComponentSystem(componentClass: TimerComponent.self)
        let autoDestructSystem = GKComponentSystem(componentClass: AutoDestructComponent.self)
        let advanceLevelSystem = GKComponentSystem(componentClass: AdvanceLevelComponent.self)
        let powerupSpawnSystem = GKComponentSystem(componentClass: PowerupSpawnerComponent.self)
        return [physicsSystem, regularMovementSystem, projectileMovementSystem, spawnSystem, enemyStateSystem,
                enemyAttackSystem, spriteSystem, timerSystem, autoDestructSystem, advanceLevelSystem,
                powerupSpawnSystem]
    }()

    init(scene: SKScene, currentSession: GameSession) {
        self.scene = scene
        self.currentSession = currentSession
        let gkScene = GKScene()
        gkScene.rootNode = scene
        self.gkScene = gkScene

        self.spellManager = SpellManager()
        self.objectiveManager = ObjectiveManager()
        self.currentSession.playerStats.levelUPObservers[ObjectIdentifier(self)] = self
    }

    func initialiseMaps() {
        MapUtil.generateMaps(withLevelType: .medium)
        addMapEntities()
    }

    func addMapEntities() {
        let mapEntities: [BaseEntity] = MapUtil.mapEntities

        for entity in mapEntities {
            add(entity)
        }
    }

    func initialiseGraph() {
        let mapEntities: [BaseMapEntity] = MapUtil.mapEntities

        self.obstacles = []

        for entity in mapEntities where entity is BaseMapObjectEntity {
            guard let mapEntity = entity as? BaseMapObjectEntity else {
                continue
            }
            if !(MapObjectConstants.globalDefaultCollidables[mapEntity.objectType] ??
                    MapObjectConstants.objectDefaultCollidable) {
                continue
            }
            var nodes: [SKNode] = []
            if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
                nodes.append(spriteComponent.node)
            }

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

    func add(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        toAdd.insert(entity)
    }

    func add(_ entity: BaseEntity) {
        add(entity as GKEntity)
        entity.entityManager = self
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        toRemove.insert(entity)
        entities.remove(entity)
    }

    func replaceSprite(_ entity: BaseEntity, component: SpriteComponent) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        entity.addComponent(component)
        scene.addChild(component.node)
    }

    func removeComponentOfEntity(_ entity: BaseEntity, component: BaseComponent) {
        for componentSystem in componentSystems {
            componentSystem.removeComponent(component)
        }
    }

    func addComponentToEntity(_ entity: BaseEntity, component: BaseComponent) {
        entity.addComponent(component)

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func spawnEnemy(at location: CGPoint, enemyType: EnemyTypeEnum) {
        let enemy = SpawnEnemyUtil.spawnEnemyWithType(enemyType, position: location)
        add(enemy)
    }

    func addPlayer() {
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        let character = PlayerEntity(position: spawnLocation, playerStats: currentSession.playerStats)
        add(character)
        self.player = character
    }

    func shootSpell(from shootPoint: CGPoint, with velocity: CGVector,
                    using elementsSelected: [Element]) throws {
        let underlyingSpell = try self.spellManager.combine(elements: elementsSelected)
        let spell = PlayerSpellEntity(velocity: velocity * ViewConstants.spellVelocityMultiplier,
                                spell: underlyingSpell, position: shootPoint)
        add(spell)
        spell.component(conformingTo: SpellSpawnOnShootComponent.self)?.createEffect()
    }

    func updateLastKnownPlayerPosition() {
        if let position = player?.component(ofType: SpriteComponent.self)?.node.position {
            lastKnownPlayerPosition = position
        }
    }

    func update(_ deltaTime: CFTimeInterval) {
        if playing {
            for componentSystem in componentSystems {
                componentSystem.update(deltaTime: deltaTime)
            }
            updateLastKnownPlayerPosition()
        }
        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        for curAdd in toAdd {
            entities.insert(curAdd)
              for componentSystem in componentSystems {
                  componentSystem.addComponent(foundIn: curAdd)
              }
        }
        toAdd.removeAll()
        toRemove.removeAll()
    }
}

extension EntityManager: LevelUPObserver {
    func onLevelUP(newLevel: Int) {
        player?.levelUp()
    }
}
