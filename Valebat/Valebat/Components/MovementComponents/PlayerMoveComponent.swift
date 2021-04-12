//
//  PlayerMoveComponent.swift
//  Valebat
//
//  Created by Zhang Yifan on 31/3/21.
//

import GameplayKit

class PlayerMoveComponent: BaseComponent, PlayerComponent, MoveComponent {
    let movementJoystick: MovementJoystick
    var orientation: CGFloat?

    var currentPosition: CGPoint
    var player: PlayerEntity?

    init(initialPosition: CGPoint, movementJoystick: MovementJoystick) {
        self.currentPosition = initialPosition
        self.movementJoystick = movementJoystick
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        movePlayer(velocity: movementJoystick.velocity * CGFloat(seconds) * GameConstants.playerMoveSpeed,
                   angular: movementJoystick.angular)
    }

    private func movePlayer(velocity: CGPoint, angular: CGFloat) {
        guard let playerSprite = player?.component(ofType: SpriteComponent.self),
              let graph = baseEntity?.entityManager?.obstacleGraph else {
            return
        }

        let adjustedVelocity = velocity * PlayerModifierUtil.playerSpeedMultiplier

        let newPosition = CGPoint(x: playerSprite.node.position.x + adjustedVelocity.x,
                                  y: playerSprite.node.position.y + adjustedVelocity.y)

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

        let nextPositionInPath: GKGraphNode2D? = path.last
        let nextX: CGFloat = CGFloat(nextPositionInPath?.position.x ?? Float(playerSprite.node.position.x))
        let nextY: CGFloat = CGFloat(nextPositionInPath?.position.y ?? Float(playerSprite.node.position.y))
        let nextPosition: CGPoint = CGPoint(x: nextX, y: nextY)

        currentPosition = nextPosition
        playerSprite.node.zRotation = angular
    }

}
