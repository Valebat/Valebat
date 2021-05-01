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

    var lastKnownPlayerPosition: CGPoint? {
        player?.component(ofType: SpriteComponent.self)?.node.position
    }
    var obstacles: [GKPolygonObstacle] = []
    let gkScene: GKScene
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?

    var playing: Bool = true

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
        initialiseLevel()
    }

    func initialiseMaps() {
        mapManager?.generateMaps(withLevelType: currentSession?.userConfig.diffLevel ?? .medium)
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
            spriteSystem.addComponent(foundIn: entity)
        }
        toAdd.insert(entity)
    }

    func add(_ entity: BaseEntity) {
        add(entity as GKEntity)
        entity.entityManager = self
    }

    private func immediateAdd(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
            scene.addChild(spriteNode)
            spriteSystem.addComponent(foundIn: entity)
        }
        entities.insert(entity)
    }

    private func immediateAdd(_ entity: BaseEntity) {
        immediateAdd(entity as GKEntity)
        entity.entityManager = self
    }

    func immediateRemove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
            spriteSystem.removeComponent(foundIn: entity)
        }
        entities.remove(entity)
    }

    private func immediateRemove(_ entity: BaseEntity) {
        immediateRemove(entity as GKEntity)
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
            spriteSystem.removeComponent(foundIn: entity)
        }
        toRemove.insert(entity)
    }

    func removeSpriteFromEntity(_ entity: BaseEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
            spriteSystem.removeComponent(foundIn: entity)
        }
    }

    func replaceSprite(_ entity: BaseEntity, component: SpriteComponent) {
        if entities.contains(entity) {
            immediateRemove(entity)
            entity.removeComponent(ofType: SpriteComponent.self)
            entity.addComponent(component)
            immediateAdd(entity)
        } else {
            entity.removeComponent(ofType: SpriteComponent.self)
            entity.addComponent(component)
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
        character.userInputInfo = scene.userInputInfo
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

    func update(_ deltaTime: CFTimeInterval) {
        if playing {
            for entity in entities {
                entity.update(deltaTime: deltaTime)
            }
        }

        for curAdd in toAdd {
            entities.insert(curAdd)
        }

        for curRemove in toRemove {
            entities.remove(curRemove)
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
