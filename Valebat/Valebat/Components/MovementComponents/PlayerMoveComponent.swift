//
//  PlayerMoveComponent.swift
//  Valebat
//
//  Created by Zhang Yifan on 31/3/21.
//

import GameplayKit

class PlayerMoveComponent: BaseComponent, PlayerComponent, MoveComponent {
    var player: PlayerEntity?

    var orientation: CGFloat?

    var currentPosition: CGPoint

    init(initialPosition: CGPoint) {
        self.currentPosition = initialPosition
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func movePlayer(velocity: CGPoint, angular: CGFloat) {
        guard let graph = baseEntity?.entityManager?.obstacleGraph else {
            return
        }

        let adjustedVelocity = velocity * PlayerModifierUtil.playerSpeedMultiplier

        let newPosition = CGPoint(x: currentPosition.x + adjustedVelocity.x,
                                  y: currentPosition.y + adjustedVelocity.y)

        let startNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(currentPosition.x),
                                                                          Float(currentPosition.y)))
        let endNode: GKGraphNode2D = GKGraphNode2D(point: vector_float2(Float(newPosition.x),
                                                                        Float(newPosition.y)))

        graph.add([startNode, endNode])
        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: endNode)
        var path: [GKGraphNode2D] = graph.findPath(from: startNode, to: endNode) as? [GKGraphNode2D] ?? []
        graph.remove([startNode, endNode])
        if !path.isEmpty { path.remove(at: 0) }

        let nextPositionInPath: GKGraphNode2D? = path.last
        let nextX = CGFloat(nextPositionInPath?.position.x ?? Float(currentPosition.x))
        let nextY = CGFloat(nextPositionInPath?.position.y ?? Float(currentPosition.y))
        currentPosition = CGPoint(x: nextX, y: nextY)
        orientation = angular
    }

}
