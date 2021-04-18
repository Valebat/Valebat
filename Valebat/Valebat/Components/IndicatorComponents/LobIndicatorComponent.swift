//
//  LobIndicatorComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/4/21.
//

import GameplayKit

class LobIndicatorComponent: AimIndicatorComponent {

    override init(size: CGSize) {
        super.init(size: size)
        node = SKShapeNode()
        node.isHidden = true
        node.zPosition = 3
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getPath(initialPosition: CGPoint, targetPosition: CGPoint, duration: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.move(to: .zero)
        let controlPoint = (targetPosition + initialPosition) / 2 +
            (CGPoint(x: 0, y: ProjectileMotionComponent.defaultHeight))
        path.addQuadCurve(to: targetPosition - initialPosition, control: controlPoint - initialPosition)
        return path
    }

    private func isLobbingOutside(target: CGPoint) -> Bool {
        let wallWidth: CGFloat = CGFloat(MapObjectConstants.globalDefaultWidths[.wall] ?? 0.0)
        let wallHeight: CGFloat = CGFloat(MapObjectConstants.globalDefaultHeights[.wall] ?? 0.0)
        return !(target.x > wallWidth && target.x < (ViewConstants.sceneWidth - wallWidth)
                    && target.y > wallHeight && target.y < (ViewConstants.sceneHeight - wallHeight))
    }

    override func onJoystickMoved(shootAngle: CGFloat, playerAngle: CGFloat?, playerPosition: CGPoint) {
        let direction = CGVector(dx: -sin(shootAngle), dy: cos(shootAngle))
        let targetPosition = playerPosition + (direction * ProjectileMotionComponent.defaultRadius).convertToPoint()
        if !isLobbingOutside(target: targetPosition) {
            (node as? SKShapeNode)?.path = getPath(initialPosition: playerPosition,
                                                   targetPosition: targetPosition,
                                                   duration: ProjectileMotionComponent.defaultDuration)
            (node as? SKShapeNode)?.lineWidth = 1.5
            node.isHidden = false
            node.zRotation = -(playerAngle ?? 0)
        } else {
            node.isHidden = true
        }
    }
}
