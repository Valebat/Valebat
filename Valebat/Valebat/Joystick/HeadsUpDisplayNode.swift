//
//  HeadsUpDisplayNode.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import SpriteKit

class HeadsUpDisplayNode: SKNode, OverlayNode {

    weak var hudInputDelegate: HUDInputDelegate?
    var movementJoystick: TLAnalogJoystick?

    override init() {
        super.init()
        movementJoystick = TLAnalogJoystick(withDiameter: 100)
        movementJoystick?.on(TLAnalogJoystickEventType.move, { joystick in
            self.hudInputDelegate?.playerJoystickMoved(velocity: joystick.velocity, angular: joystick.angular)
        })
        if let movementJoystick = movementJoystick {
            self.addChild(movementJoystick)
        }
    }

    convenience init(screenSize: CGSize) {
        self.init()
        movementJoystick?.position = CGPoint(x: screenSize.width * 0.2, y: screenSize.height * 0.2)
        movementJoystick?.zPosition = ViewConstants.joystickZPosition
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
