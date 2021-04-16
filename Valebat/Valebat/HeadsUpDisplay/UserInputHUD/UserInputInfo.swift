//
//  UserInputInfo.swift
//  Valebat
//
//  Created by Zhang Yifan on 16/4/21.
//

import CoreGraphics

class UserInputInfo {
    var movementJoystickAngular: CGFloat = CGFloat.zero
    var movementJoystickVelocity: CGPoint = CGPoint.zero

    var spellJoystickAngular: CGFloat = CGFloat.zero
    var spellJoystickEnd: Bool = false
    var spellJoystickMoved: Bool = false

    var elementQueueArray: [BasicType] = []
    private(set) var elementQueueCount: Int = HUDConstants.elementQueueLength

    func setNewElement(elementType: BasicType) {
        if elementQueueArray.count == elementQueueCount {
            elementQueueArray.removeFirst()
        }
        elementQueueArray.append(elementType)
    }

    func clearElementQueue() {
        elementQueueArray.removeAll()
    }
}
