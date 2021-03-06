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
    weak var userInputInfo: UserInputInfo?

    private(set) var movementJoystick: MovementJoystick?
    private(set) var spellJoystick: SpellJoystick?

    private(set) var elementPane: ElementPane?

    private(set) var outcomeButton: OutcomeButton?

    override init() {
        super.init()
        self.zPosition = HUDConstants.joystickZPosition
        self.name = "input"

        setUpJoysticks()
        setUpElementPane()
        setUpRestartButton()
    }

    private func setUpRestartButton() {
        outcomeButton = OutcomeButton()
        if let button = outcomeButton {
            self.addChild(button)
        }
    }

    public func toggleOutcomeButton(success: Bool) {
        if !success {
            outcomeButton?.texture = SKTexture(imageNamed: "lose-pop")
        } else {
            outcomeButton?.texture = SKTexture(imageNamed: "win-pop")
        }
        outcomeButton?.popUp()
    }

    public func assignInputDelegate(delegate: UserInputDelegate) {
        outcomeButton?.restartButton.userInputDelegate = delegate
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

        elementPane?.userInputNode = self
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
