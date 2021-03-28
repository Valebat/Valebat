//
//  EnemyMoveComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit

class EnemyMoveComponent: GKComponent {

    var speed: CGFloat
    var nextPositions = [CGPoint]()
    let pathTimerCooldown = 0.5
    var currentPathTimerCooldown = 0.0
    private weak var cachedSpriteComponent: SpriteComponent?
    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }

    private func getSpriteComponent() -> SpriteComponent? {
        if cachedSpriteComponent == nil {
            cachedSpriteComponent = entity?.component(ofType: SpriteComponent.self)
        }
        return cachedSpriteComponent
    }

    func hasNextPosition() -> Bool {
        !nextPositions.isEmpty
    }

    func getNextPosition() -> CGPoint? {
        nextPositions.removeFirst()
    }

    override func update(deltaTime seconds: TimeInterval) {
        moveTowardsPlayer(deltaTime: seconds)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getNewPath(targetLocation: CGPoint) {
        guard let spriteComponent = getSpriteComponent(),
              let graph = EntityManager.getInstance().obstacleGraph else {
            return
        }
        let position = spriteComponent.node.position
        var startNode = GKGraphNode2D(point: vector_float2(Float(position.x),
                                                          Float(position.y)))
        let endNode =  GKGraphNode2D(point: vector_float2(Float(targetLocation.x),
                                                          Float(targetLocation.y)))
        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: endNode)
        var path = graph.findPath(from: startNode, to: endNode)
        graph.remove([startNode])

        if path.isEmpty {
            let directions: [CGPoint] = [CGPoint(x: 1, y: 1), CGPoint(x: -1, y: -1),
                                         CGPoint(x: -1, y: 1), CGPoint(x: 1, y: -1)]
            for idx in 0..<directions.count {
                let newPosition = CGPoint(x: CGFloat(position.x) +
                                            directions[idx].x * ViewConstants.baseEnemyEscapeDistance,
                                          y: CGFloat(position.y) +
                                            directions[idx].y * ViewConstants.baseEnemyEscapeDistance)

                startNode = GKGraphNode2D(point: vector_float2(Float(newPosition.x),
                                                                Float(newPosition.y)))
                graph.connectUsingObstacles(node: startNode)

                path = graph.findPath(from: startNode, to: endNode)
                graph.remove([startNode])

                if let nextPositionInPath: GKGraphNode2D = path.first as? GKGraphNode2D {
                    let targetX: CGFloat = CGFloat(nextPositionInPath.position.x)
                    let targetY: CGFloat = CGFloat(nextPositionInPath.position.y)
                    spriteComponent.node.position = CGPoint(x: targetX, y: targetY)
                    break
                }
            }
        }
        graph.remove([endNode])
        guard let path2D = path as? [GKGraphNode2D] else {
            return
        }

        nextPositions = path2D.map({ CGPoint(x: CGFloat($0.position.x), y: CGFloat($0.position.y)) })
        nextPositions.removeFirst()

    }

    func computeNewPosition(deltaTime: TimeInterval) {
        guard var currentPosition = getSpriteComponent()?.node.position else {
            return
        }
        var currentTime = CGFloat(deltaTime)
        while currentTime > 0 {
            guard let nextPosition = nextPositions.first else {
                break
            }
            let vector = (nextPosition - currentPosition).convertToVector()
            let distance = vector.length()
            if distance < speed * currentTime {
                currentTime -= distance/speed
                currentPosition = nextPosition
                nextPositions.removeFirst()
            } else {
                let deltaVector = vector.normalized() * speed * currentTime
                currentPosition = deltaVector.convertToPoint() + currentPosition
                currentTime = -1
            }
        }
        getSpriteComponent()?.node.position = currentPosition
    }

    private func moveTowardsPlayer(deltaTime: TimeInterval) {
        currentPathTimerCooldown -= deltaTime
        if currentPathTimerCooldown < 0 {
            if let targetLocation = EntityManager.getInstance().lastKnownPlayerPosition {
                getNewPath(targetLocation: targetLocation)
            }
            currentPathTimerCooldown = pathTimerCooldown
        }
        computeNewPosition(deltaTime: deltaTime)
    }

}
