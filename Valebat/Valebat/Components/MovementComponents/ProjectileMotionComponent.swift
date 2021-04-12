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

    let targetPosition: CGPoint
    let initialPosition: CGPoint
    let duration: CGFloat
    var currentPosition: CGPoint
    var time: CGFloat = 0
    var orientation: CGFloat?
    var stop: Bool = false

    required init(velocity: CGVector, initialPosition: CGPoint) {
        self.initialPosition = initialPosition
        self.targetPosition = initialPosition + (velocity.normalized() * ProjectileMotionComponent.defaultRadius).convertToPoint()
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
        if time < duration {
            time += CGFloat(seconds)
            let height: CGVector
            if time < duration / 2 {
                height = lerp(start: CGVector(dx: 0, dy: 0),
                              end: CGVector(dx: 0, dy: 100),
                              linearT: 2*time/duration)
            } else {
                height = lerp(start: CGVector(dx: 0, dy: 100),
                              end: CGVector(dx: 0, dy: 0),
                              linearT: (2*time/duration) - 1)
            }
            currentPosition = lerp(start: initialPosition.convertToVector(),
                                   end: targetPosition.convertToVector(),
                                   linearT: time/duration).convertToPoint() + height.convertToPoint()
        }
    }
}
