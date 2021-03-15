//
//  HeadsUpDisplayNode.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import SpriteKit

class HeadsUpDisplayNode: SKNode, OverlayNode {

    weak var userInputDelegate: UserInputDelegate?
    var movementJoystick: TLAnalogJoystick?
    var spellJoystick: TLAnalogJoystick?

    var elementPane: ElementPane?

    override init() {
        super.init()
        self.zPosition = HUDConstants.joystickZPosition
        movementJoystick = TLAnalogJoystick(withDiameter: 100)
        let mvmtJoystickMoved: TLAnalogJoystickEventHandler = { joystick in
            if joystick.velocity.length() < 0.2 {
                return
            }
            self.userInputDelegate?.playerJoystickMoved(velocity: joystick.velocity, angular: joystick.angular)
        }
        movementJoystick?.on(TLAnalogJoystickEventType.move, mvmtJoystickMoved)
        if let movementJoystick = movementJoystick {
            self.addChild(movementJoystick)
        }

        spellJoystick = TLAnalogJoystick(withDiameter: 100)
        let spellJoystickEnded: TLAnalogJoystickEventHandler = { joystick in
            // do nothing if distance is small?
            self.userInputDelegate?.spellJoystickEnded(angular: joystick.angular)
        }
        spellJoystick?.on(TLAnalogJoystickEventType.end, spellJoystickEnded)
        if let spellJoystick = spellJoystick {
            self.addChild(spellJoystick)
        }
    }

    convenience init(screenSize: CGSize) {
        self.init()
        movementJoystick?.position = CGPoint(x: screenSize.width * 0.2, y: screenSize.height * 0.2)
        spellJoystick?.position = CGPoint(x: screenSize.width * 0.8, y: screenSize.height * 0.2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
