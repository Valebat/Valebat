//
//  PlayerMoveComponent.swift
//  Valebat
//
//  Created by Zhang Yifan on 31/3/21.
//

import GameplayKit
import CoreGraphics

class PlayerMoveComponent: MoveComponent, PlayerComponent {
    var player: PlayerEntity?

    init(initialPosition: CGPoint) {
        super.init(position: initialPosition)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func isValid(point: CGPoint) -> Bool {
        guard let obstacles = self.baseEntity?.entityManager?.obstacles else {
            return true
        }
        for polyObstacle in obstacles {
            let path = CGMutablePath()
            for idx in 0..<polyObstacle.vertexCount {
                let pair = polyObstacle.vertex(at: idx)
                let pointToAdd = CGPoint(x: CGFloat(pair.x), y: CGFloat(pair.y))
                if idx == 0 {
                    path.move(to: pointToAdd)
                } else {
                    path.addLine(to: pointToAdd)
                }
            }
            path.closeSubpath()
            let widePath = path.copy(strokingWithWidth: ViewConstants.playerWidth / 2,
                                     lineCap: .butt, lineJoin: .miter, miterLimit: 0)
            if widePath.contains(point) {
                return false
            }
        }
        return true
    }

    override func update(deltaTime seconds: TimeInterval) {
        let userInput = player?.userInputInfo
        let adjustedVelocity =  (userInput?.movementJoystickVelocity ?? .zero) * CGFloat(seconds)
            * GameConstants.playerMoveSpeed * player!.playerModifiers.playerSpeedMultiplier
        let newPosition = CGPoint(x: currentPosition.x + adjustedVelocity.x,
                                  y: currentPosition.y + adjustedVelocity.y)
        if isValid(point: newPosition) {
            currentPosition = newPosition
        }
        orientation = userInput?.movementJoystickAngular
    }
}
