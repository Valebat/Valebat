//
//  EnemyMoveComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyMoveComponent: MoveComponent {
    var speed: CGFloat = 200 // For boss
    var nextPositions = [CGPoint]()
    var currentRandomPathCoolDown = 3.0
    let randomPathCoolDown = 3.0
    let pathTimerCooldown = 0.5
    var currentPathTimerCooldown = 0.0

    init(initialPosition: CGPoint) {
        super.init(position: initialPosition)
    }

    func reset() {
        currentPathTimerCooldown = 0.0
        currentRandomPathCoolDown = 0.0
        nextPositions = [CGPoint]()
    }

    func hasNextPosition() -> Bool {
        !nextPositions.isEmpty
    }

    func getNextPosition() -> CGPoint? {
        nextPositions.removeFirst()
    }

    override func update(deltaTime seconds: TimeInterval) {
        computeNewPosition(deltaTime: seconds, speed: speed)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getNewPath(targetLocation: CGPoint) {
        guard let graph = baseEntity?.entityManager?.obstacleGraph else {
            return
        }
        var startNode = GKGraphNode2D(point: vector_float2(Float(currentPosition.x),
                                                          Float(currentPosition.y)))
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
                let newPosition = CGPoint(x: currentPosition.x +
                                            directions[idx].x * ViewConstants.baseEnemyEscapeDistance,
                                          y: currentPosition.y +
                                            directions[idx].y * ViewConstants.baseEnemyEscapeDistance)

                startNode = GKGraphNode2D(point: vector_float2(Float(newPosition.x),
                                                                Float(newPosition.y)))
                graph.connectUsingObstacles(node: startNode)

                path = graph.findPath(from: startNode, to: endNode)
                graph.remove([startNode])

                if let nextPositionInPath: GKGraphNode2D = path.first as? GKGraphNode2D {
                    let targetX: CGFloat = CGFloat(nextPositionInPath.position.x)
                    let targetY: CGFloat = CGFloat(nextPositionInPath.position.y)
                    currentPosition = CGPoint(x: targetX, y: targetY)
                    break
                }
            }
        }
        graph.remove([endNode])
        guard let path2D = path as? [GKGraphNode2D] else {
            return
        }

        nextPositions = path2D.map({ CGPoint(x: CGFloat($0.position.x), y: CGFloat($0.position.y)) })
        if !nextPositions.isEmpty {
            nextPositions.removeFirst()
        }

    }

    private func computeNewPosition(deltaTime: TimeInterval, speed: CGFloat) {
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
    }

    private func getRandomPathinRadius(origin: CGPoint, radius: CGFloat) {
        for _ in 1 ... 5 {
            let randomLocation = CGPoint.getCGPoint(magnitude: CGFloat.random(in: 0 ... radius),
                                                    degrees: CGFloat.random(in: 0 ... 360)) + origin
            getNewPath(targetLocation: randomLocation)
            if !nextPositions.isEmpty {
                break
            }
        }
    }

    func moveToRandomLocationInRadius(deltaTime: TimeInterval, with speed: CGFloat) {
        currentRandomPathCoolDown -= deltaTime
        if currentRandomPathCoolDown < 0 {
            getRandomPathinRadius(origin: currentPosition, radius: 100)
            currentRandomPathCoolDown = randomPathCoolDown
        }
        self.speed = speed
    }

    func moveTowardsPlayer(deltaTime: TimeInterval, with speed: CGFloat) {
        currentPathTimerCooldown -= deltaTime
        if currentPathTimerCooldown < 0 {
            if let targetLocation = baseEntity?.entityManager?.lastKnownPlayerPosition {
                getNewPath(targetLocation: targetLocation)
            }
            currentPathTimerCooldown = pathTimerCooldown
        }
        self.speed = speed
    }

    func stopMoving() {
        nextPositions.removeAll()
    }

}
