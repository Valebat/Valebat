//
//  UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import CoreGraphics

protocol UserInputDelegate: AnyObject {

    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat)

    func spellJoystickEnded(angular: CGFloat, elementQueue: [BasicType]?)

}
