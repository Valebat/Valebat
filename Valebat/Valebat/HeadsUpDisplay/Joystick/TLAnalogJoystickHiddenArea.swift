//
//  TLAnalogJoystickHiddenArea.swift
//
//  Created by Dmitriy Mitrophanskiy on 2/27/19.
//  Copyright © 2019 Dmitriy Mitrophanskiy. All rights reserved.
//

import SpriteKit

// MARK: - TLAnalogJoystickHiddenArea
open class TLAnalogJoystickHiddenArea: SKShapeNode {
    private var currJoystick: TLAnalogJoystick?

    var joystick: TLAnalogJoystick? {
        get {
            return currJoystick
        }

        set {
            if let currJoystick = self.currJoystick {
                removeChildren(in: [currJoystick])
            }

            currJoystick = newValue

            if let currJoystick = self.currJoystick {
                isUserInteractionEnabled = true
                cancelNode(currJoystick)
                addChild(currJoystick)
            } else {
                isUserInteractionEnabled = false
            }
        }
    }

    private func cancelNode(_ node: SKNode) {
        node.isHidden = true
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currJoystick = self.currJoystick else {
            return
        }

        let firstTouch = touches.first!
        currJoystick.position = firstTouch.location(in: self)
        currJoystick.isHidden = false
        currJoystick.touchesBegan(touches, with: event)
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currJoystick = self.currJoystick else {
            return
        }

        currJoystick.touchesMoved(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currJoystick = self.currJoystick else {
            return
        }

        currJoystick.touchesEnded(touches, with: event)
        cancelNode(currJoystick)
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currJoystick = self.currJoystick else {
            return
        }

        currJoystick.touchesCancelled(touches, with: event)
        cancelNode(currJoystick)
    }
}
