//
//  HUDConstants.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import CoreGraphics

struct HUDConstants {
    static let joystickVelocityMultiplier: CGFloat = 0.1
    static let joystickZPosition: CGFloat = 50
    static let joystickDiameter: CGFloat = 100
    static let movementJoystickPos: CGPoint = CGPoint(x: 680, y: 128)
    static let spellJoystickPos: CGPoint = CGPoint(x: 170, y: 128)

    static let elementQueueStartPos: CGPoint = CGPoint(x: 250, y: 50)
    static let elementPaneZPosition: CGFloat = 51
    static let elementQueueZPosition: CGFloat = 52
    static let elementQueueGridSize: CGSize = CGSize(width: 34, height: 34)
    static let elementQueueElementSize: CGSize = CGSize(width: 30, height: 30)
    static let elementQueueLength: Int = 3
}
