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

        setUpJoysticks()
        setUpElementPane()

    }

    private func setUpJoysticks() {
        movementJoystick = TLAnalogJoystick(withDiameter: HUDConstants.joystickDiameter)
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

        spellJoystick = TLAnalogJoystick(withDiameter: HUDConstants.joystickDiameter)
        let spellJoystickEnded: TLAnalogJoystickEventHandler = { joystick in
            if joystick.velocity.length() < 0.2 {
                return
            }
            self.userInputDelegate?.spellJoystickEnded(angular: joystick.angular,
                                                       elementQueue: self.elementPane?.elementQueueArray)
        }
        spellJoystick?.on(TLAnalogJoystickEventType.end, spellJoystickEnded)
        if let spellJoystick = spellJoystick {
            self.addChild(spellJoystick)
        }
    }

    private func setUpElementPane() {
        elementPane = ElementPane()

        if let elementPane = elementPane {
            self.addChild(elementPane)
        }
    }

    convenience init(screenSize: CGSize) {
        self.init()
        movementJoystick?.position = HUDConstants.movementJoystickPos
        spellJoystick?.position = HUDConstants.spellJoystickPos
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
