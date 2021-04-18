//
//  MovementJoystick.swift
//  Valebat
//
//  Created by Zhang Yifan on 1/4/21.
//

import SpriteKit

class MovementJoystick: TLAnalogJoystick {
    weak var userInputNode: UserInputNode?

    convenience init() {
        let diameter = HUDConstants.joystickDiameter
        let handleRatio: CGFloat = 0.6
        let base = TLAnalogJoystickComponent(diameter: diameter, color: .gray, opacity: 0.6)
        let handleDiameter = getDiameter(fromDiameter: diameter, withRatio: handleRatio)
        let handle = TLAnalogJoystickComponent(diameter: handleDiameter, color: .black, opacity: 0.6)
        self.init(withBase: base, handle: handle)
    }

    override func didJoystickMove() {
        userInputNode?.userInputInfo?.movementJoystickAngular = self.angular
        userInputNode?.userInputInfo?.movementJoystickVelocity = self.velocity
    }

    override func didJoystickEnd() {
        userInputNode?.userInputInfo?.movementJoystickAngular = CGFloat.zero
        userInputNode?.userInputInfo?.movementJoystickVelocity = CGPoint.zero
    }

    override init(withBase: TLAnalogJoystickComponent, handle: TLAnalogJoystickComponent) {
        super.init(withBase: withBase, handle: handle)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
