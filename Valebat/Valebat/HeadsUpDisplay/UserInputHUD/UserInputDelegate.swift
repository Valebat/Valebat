//
//  UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import CoreGraphics

protocol UserInputDelegate: AnyObject {
    func spellJoystickEnded(angular: CGFloat, elementQueue: [BasicType]?)
    func spellJoystickMoved(angular: CGFloat)
    func restartClicked()
}
