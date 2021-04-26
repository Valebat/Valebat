//
//  ElementSelection.swift
//  Valebat
//
//  Created by Zhang Yifan on 17/3/21.
//

import SpriteKit

class ElementSelection: SKNode {
    weak var elementPane: ElementPane?

    override init() {
        super.init()
        let position = HUDConstants.spellJoystickPos
        let distance = HUDConstants.joystickDiameter
        initButton(elementType: .water, position: CGPoint(x: position.x, y: position.y + distance))
        initButton(elementType: .fire, position: CGPoint(x: position.x - distance / sqrt(2),
                                                          y: position.y + distance / sqrt(2)))
        initButton(elementType: .earth, position: CGPoint(x: position.x - distance, y: position.y))
    }

    func setNewElement(elementType: BasicType) {
        elementPane?.setNewElement(elementType: elementType)
    }

    private func initButton(elementType: BasicType, position: CGPoint) {
        let button = ElementButton(elementType: elementType)
        button.position = position
        self.addChild(button)
        button.elementSelection = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
