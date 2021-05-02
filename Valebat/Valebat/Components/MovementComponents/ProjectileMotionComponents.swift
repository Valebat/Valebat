//
//  ProjectileMotionComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 10/4/21.
//

import SpriteKit
import GameplayKit

class ProjectileMotionComponent: SpellMovementComponent {

    override class var identifier: String {
        "projectile"
    }
    static let defaultDuration: CGFloat = 1
    static let defaultRadius: CGFloat = 200
    static let defaultHeight: CGFloat = 100

    let targetPosition: CGPoint
    let initialPosition: CGPoint
    let duration: CGFloat
    var time: CGFloat = 0
    var stop: Bool = false

    required init(velocity: CGVector, initialPosition: CGPoint) {
        self.initialPosition = initialPosition
        let targetPosition = initialPosition +
            (velocity.normalized() * ProjectileMotionComponent.defaultRadius).convertToPoint()
        self.duration = ProjectileMotionComponent.defaultDuration
        self.targetPosition = targetPosition
        super.init(initialPosition: initialPosition,
                   shootAngle: atan2(targetPosition.y - initialPosition.y,
                                     targetPosition.x - initialPosition.x))
    }

    init(targetPosition: CGPoint, initialPosition: CGPoint, duration: CGFloat) {
        self.initialPosition = initialPosition
        self.targetPosition = targetPosition
        self.duration = duration
        super.init(initialPosition: initialPosition,
                   shootAngle: atan2(targetPosition.y - initialPosition.y,
                                     targetPosition.x - initialPosition.x))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        time += CGFloat(seconds)
        if time < duration {
            currentPosition = getPoint(at: time / duration, initialPosition: initialPosition,
                                       targetPosition: targetPosition)
        } else {
            baseEntity?.component(conformingTo: SpellEffectComponent.self)?.createEffect()
        }
    }

    func getPoint(at prop: CGFloat, initialPosition: CGPoint, targetPosition: CGPoint) -> CGPoint {
        let controlPoint = (targetPosition + initialPosition) / 2 +
            (CGPoint(x: 0, y: ProjectileMotionComponent.defaultHeight))
        let firstTerm = initialPosition * pow(1 - prop, 2)
        let secondTerm = controlPoint * 2 * prop * (1 - prop)
        let thirdTerm = targetPosition * pow(prop, 2)
        return firstTerm + secondTerm + thirdTerm
    }
}
