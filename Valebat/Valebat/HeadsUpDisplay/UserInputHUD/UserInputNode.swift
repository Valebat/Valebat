//
//  UserInputNode.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import SpriteKit

protocol UserInputNodeProtocol: AnyObject {

    var userInputDelegate: UserInputDelegate? { get set }
}

class UserInputNode: SKNode {

    private(set) var movementJoystick: MovementJoystick?
    private(set) var spellJoystick: SpellJoystick?

    private(set) var elementPane: ElementPane?

    override init() {
        super.init()
        self.zPosition = HUDConstants.joystickZPosition

        setUpJoysticks()
        setUpElementPane()

    }

    public func assignInputDelegate(delegate: UserInputDelegate) {
        movementJoystick?.userInputDelegate = delegate
        spellJoystick?.userInputDelegate = delegate
    }

    private func setUpJoysticks() {
        movementJoystick = MovementJoystick()
        if let movementJoystick = movementJoystick {
            self.addChild(movementJoystick)
            movementJoystick.userInputNode = self
        }

        spellJoystick = SpellJoystick()
        if let spellJoystick = spellJoystick {
            self.addChild(spellJoystick)
            spellJoystick.userInputNode = self
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
