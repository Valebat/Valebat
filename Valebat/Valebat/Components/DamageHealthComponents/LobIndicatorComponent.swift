//
//  LobIndicatorComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/4/21.
//

import GameplayKit

class LobIndicatorComponent: GKSKNodeComponent {

    init(initialPosition: CGPoint) {
        super.init()
        node = SKShapeNode()
        node.isHidden = true
        node.zPosition = 3
    }

    func getPath(initialPosition: CGPoint, targetPosition: CGPoint, duration: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.move(to: .zero)
        let controlPoint = (targetPosition + initialPosition) / 2 + (CGPoint(x: 0, y: ProjectileMotionComponent.defaultHeight))
        path.addQuadCurve(to: targetPosition - initialPosition, control: controlPoint - initialPosition)
        return path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddToEntity() {
        entity?.component(ofType: SpriteComponent.self)?.node.addChild(self.node)
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        super.willRemoveFromEntity()
    }

    func onJoystickEnded() {
        node.isHidden = true
    }

    func onJoystickMoved(angle: CGFloat, playerAngle: CGFloat?, direction: CGVector, initialPosition: CGPoint) {
        let targetPosition = initialPosition + (direction * ProjectileMotionComponent.defaultRadius).convertToPoint()
        (node as? SKShapeNode)?.path = getPath(initialPosition: initialPosition, targetPosition: targetPosition ,
                            duration: ProjectileMotionComponent.defaultDuration)
        (node as? SKShapeNode)?.lineWidth = 1.5
        node.isHidden = false
        node.zRotation = -(playerAngle ?? 0)
    }
}
