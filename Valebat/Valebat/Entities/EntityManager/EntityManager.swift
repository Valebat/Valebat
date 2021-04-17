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
    weak var currentSession: BaseGameSession?
    weak var mapManager: MapManager?
    weak var scene: GameScene!

    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    var toAdd = Set<GKEntity>()
    var player: PlayerEntity?

    var spriteSystem: GKComponentSystem<GKComponent>

    var lastKnownPlayerPosition: CGPoint?
    var obstacles: [GKPolygonObstacle] = []
    let gkScene: GKScene
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?

    var playing: Bool = true

    lazy var componentSystems: [GKComponentSystem] = {
        let physicsSystem = GKComponentSystem(componentClass: PhysicsComponent.self)
        let regularMovementSystem = GKComponentSystem(componentClass: RegularMovementComponent.self)
        let projectileMovementSystem = GKComponentSystem(componentClass: ProjectileMotionComponent.self)
        let spawnSystem = GKComponentSystem(componentClass: SpawnComponent.self)
        let enemyStateSystem = GKComponentSystem(componentClass: EnemyStateMachineComponent.self)
        let enemyAttackSystem = GKComponentSystem(componentClass: EnemyAttackComponent.self)
        let bossStateMachineSystem = GKComponentSystem(componentClass: BossStateMachineComponent.self)
        let bossAttackSystem = GKComponentSystem(componentClass: BossAttackComponent.self)
        let advanceLevelSystem = GKComponentSystem(componentClass: AdvanceLevelComponent.self)
        let powerupSpawnSystem = GKComponentSystem(componentClass: PowerupSpawnerComponent.self)
        let playerMovementSystem = GKComponentSystem(componentClass: PlayerMoveComponent.self)
        let autoDestructSystem = GKComponentSystem(componentClass: AutoDestructComponent.self)

        return [physicsSystem, regularMovementSystem, projectileMovementSystem, spawnSystem, enemyStateSystem,
                enemyAttackSystem, bossStateMachineSystem, bossAttackSystem, spriteSystem,
                advanceLevelSystem, powerupSpawnSystem, autoDestructSystem, playerMovementSystem]
    }()

    init(scene: GameScene) {
        self.scene = scene
        let gkScene = GKScene()
        gkScene.rootNode = scene
        self.gkScene = gkScene
        self.spriteSystem = GKComponentSystem(componentClass: SpriteComponent.self)
    }

    func setup() {
        self.currentSession?.playerStats.levelUPObservers[ObjectIdentifier(self)] = self
        initialiseMaps()
        initialiseGraph()
        initialiseObservers()
    }

    func initialiseMaps() {
        mapManager?.generateMaps(withLevelType: currentSession?.userConfig.diffLevel ?? .medium)
        immediateAddMapEntities()
    }

    /// This function is to bypass toAdd on initialisation (as we don't have to accommodate the update loop).
    /// Do not call this while the game is running.
    func immediateAddMapEntities() {
        guard let mapManager = self.mapManager else {
            return
        }
        let mapEntities: [BaseEntity] = mapManager.mapEntities

        for entity in mapEntities {
            immediateAdd(entity)
        }
    }

    func initialiseGraph() {
        guard let mapManager = self.mapManager else {
            return
        }
        let mapEntities: [BaseMapEntity] = mapManager.mapEntities

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

    private func immediateAdd(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        entities.insert(entity)
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    private func immediateAdd(_ entity: BaseEntity) {
        immediateAdd(entity as GKEntity)
        entity.entityManager = self
    }

    func immediateRemove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        for componentSystem in componentSystems {
            componentSystem.removeComponent(foundIn: entity)
        }
        entities.remove(entity)
    }

    private func immediateRemove(_ entity: BaseEntity) {
        immediateRemove(entity as GKEntity)
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        toRemove.insert(entity)
        entities.remove(entity)
    }

    func replaceSprite(_ entity: BaseEntity, component: SpriteComponent) {
        for componentSystem in componentSystems {
            componentSystem.removeComponent(foundIn: entity)
        }

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        entity.addComponent(component)

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }

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
        guard let currentSession = self.currentSession else {
            return
        }
        let spawnLocation = CGPoint(x: scene.size.width * ViewConstants.playerSpawnOffset,
                                y: scene.size.height * ViewConstants.playerSpawnOffset)
        let character = PlayerEntity(position: spawnLocation, playerStats: currentSession.playerStats,
                                     entityManager: self)
        add(character)
        self.player = character
    }

    func shootSpell(from shootPoint: CGPoint, with velocity: CGVector,
                    using elementsSelected: [Element]) throws {
        guard let underlyingSpell = try self.currentSession?
                .spellManager.combine(elements: elementsSelected) else {
            return
        }
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
       // entities.forEach({ $0.update(deltaTime: deltaTime )})
        if playing {
            for componentSystem in componentSystems {
                componentSystem.update(deltaTime: deltaTime)
            }
            // entities.forEach({ $0.update(deltaTime: deltaTime )})
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

        updateShoot()
    }

    private func updateShoot() {
        if scene.userInputInfo.spellJoystickMoved {
            spellJoystickMoved(angular: scene.userInputInfo.spellJoystickAngular,
                               elementQueue: scene.userInputInfo.elementQueueArray)
        } else if scene.userInputInfo.spellJoystickEnd {
            spellJoystickEnded(angular: scene.userInputInfo.spellJoystickAngular,
                               elementQueue: scene.userInputInfo.elementQueueArray)
            scene.userInputInfo.spellJoystickEnd = false
        }
    }
}

extension EntityManager: LevelUPObserver {
    func onLevelUP(newLevel: Int) {
        player?.levelUp()
    }
}