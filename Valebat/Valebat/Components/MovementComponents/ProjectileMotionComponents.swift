//
//  ProjectileMotionComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 10/4/21.
//

import SpriteKit
import GameplayKit

class ProjectileMotionComponent: BaseComponent, SpellMovementComponent {

    static let defaultDuration: CGFloat = 1
    static let defaultRadius: CGFloat = 200
    static let defaultHeight: CGFloat = 100

    let targetPosition: CGPoint
    let initialPosition: CGPoint
    let duration: CGFloat
    var currentPosition: CGPoint
    var time: CGFloat = 0
    var orientation: CGFloat?
    var stop: Bool = false

    required init(velocity: CGVector, initialPosition: CGPoint) {
        self.initialPosition = initialPosition
        self.targetPosition = initialPosition +
            (velocity.normalized() * ProjectileMotionComponent.defaultRadius).convertToPoint()
        self.duration = ProjectileMotionComponent.defaultDuration
        currentPosition = initialPosition
        orientation = atan2(self.targetPosition.y - currentPosition.y,
                            self.targetPosition.x - currentPosition.x)
        super.init()
    }

    init(targetPosition: CGPoint, initialPosition: CGPoint, duration: CGFloat) {
        self.initialPosition = initialPosition
        self.targetPosition = targetPosition
        self.duration = duration
        currentPosition = initialPosition
        self.time = 0
        orientation = atan2(self.targetPosition.y - currentPosition.y,
                            self.targetPosition.x - currentPosition.x)
        stop = false
        super.init()
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
            guard let entityManager = baseEntity?.entityManager else {
                return
            }
            let explosionPosition = currentPosition
            let explosion = ExplosionEntity(position: explosionPosition, scale: 4)
            entityManager.add(explosion)
            if let entity = self.baseEntity {
                entityManager.remove(entity)
            }
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
