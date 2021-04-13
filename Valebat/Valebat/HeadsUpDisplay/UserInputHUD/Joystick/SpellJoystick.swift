//
//  SpellJoystick.swift
//  Valebat
//
//  Created by Zhang Yifan on 1/4/21.
//

import SpriteKit

class SpellJoystick: TLAnalogJoystick, UserInputNodeProtocol {

    weak var userInputDelegate: UserInputDelegate?
    weak var userInputNode: UserInputNode?

    override func didJoystickEnd() {
        if self.velocity.length() < 0.2 {
            return
        }
        self.userInputDelegate?.spellJoystickEnded(angular: self.angular,
                                                   elementQueue: userInputNode?.elementPane?.elementQueueArray)
    }

    override func didJoystickMove() {
        self.userInputDelegate?.spellJoystickMoved(angular: self.angular,
                                                   elementQueue: userInputNode?.elementPane?.elementQueueArray)
    }

    convenience init() {
        let diameter = HUDConstants.joystickDiameter
        let handleRatio: CGFloat = 0.6
        let base = TLAnalogJoystickComponent(diameter: diameter, color: .gray, opacity: 0.6)
        let handleDiameter = getDiameter(fromDiameter: diameter, withRatio: handleRatio)
        let handle = TLAnalogJoystickComponent(diameter: handleDiameter, color: .black, opacity: 0.6)
        self.init(withBase: base, handle: handle)
    }

    override init(withBase: TLAnalogJoystickComponent, handle: TLAnalogJoystickComponent) {
        super.init(withBase: withBase, handle: handle)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
