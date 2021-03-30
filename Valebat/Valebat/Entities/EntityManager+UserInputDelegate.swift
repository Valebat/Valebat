//
//  EntityManager+UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 18/3/21.
//

import CoreGraphics
import GameplayKit

extension EntityManager: UserInputDelegate {
    func spellJoystickEnded(angular: CGFloat, elementQueue: [BasicType]?) {
        guard let playerPos = player?.component(ofType: SpriteComponent.self)?.node.position else {
            return
        }

        let direction = CGVector(dx: -sin(angular), dy: cos(angular))
        let elementTypeQueue = elementQueue ?? []
        let elementQueue = mapBasicType(elementQueue: elementTypeQueue)
        do {
            try shootSpell(from: playerPos, with: direction, using: elementQueue)
        } catch SpellErrors.invalidLevelError {
            print("Wrong level was given")
        } catch SpellErrors.wrongBasicTypeError {
            print("Wrong element type was given")
        } catch {
            print("Unexpected error")
        }
    }

    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat) {
        guard let playerSprite = player?.component(ofType: SpriteComponent.self) else {
            return
        }

        let newPosition = CGPoint(x: playerSprite.node.position.x
                                    + velocity.x * HUDConstants.joystickVelocityMultiplier,
                                  y: playerSprite.node.position.y
                                    + velocity.y * HUDConstants.joystickVelocityMultiplier)

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

        let nextPositionInPath: GKGraphNode2D? = path.last
        let nextX: CGFloat = CGFloat(nextPositionInPath?.position.x ?? Float(playerSprite.node.position.x))
        let nextY: CGFloat = CGFloat(nextPositionInPath?.position.y ?? Float(playerSprite.node.position.y))
        let nextPosition: CGPoint = CGPoint(x: nextX, y: nextY)

        playerSprite.node.position = nextPosition
        playerSprite.node.zRotation = angular
    }

    private func mapBasicType(elementQueue: [BasicType]) -> [Element] {
        return elementQueue.compactMap({ self.elements[$0] ?? nil })
    }
}
