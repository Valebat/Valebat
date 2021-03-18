//
//  UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 14/3/21.
//

import CoreGraphics

protocol UserInputDelegate: AnyObject {

    func inputBegan(at location: CGPoint)

    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat)

    func spellJoystickEnded(angular: CGFloat)

}
