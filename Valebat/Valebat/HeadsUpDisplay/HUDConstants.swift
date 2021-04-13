//
//  HUDConstants.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import CoreGraphics

struct HUDConstants {
    static let joystickZPosition: CGFloat = 50
    static let joystickDiameter: CGFloat = 100
    static let spellJoystickPos: CGPoint = CGPoint(x: 680, y: 128)
    static let movementJoystickPos: CGPoint = CGPoint(x: 170, y: 128)

    static let elementQueueStartPos: CGPoint = CGPoint(x: 600, y: 50)
    static let elementPaneZPosition: CGFloat = 51
    static let elementQueueZPosition: CGFloat = 52
    static let elementQueueGridSize: CGSize = CGSize(width: 34, height: 34)
    static let elementQueueElementSize: CGSize = CGSize(width: 30, height: 30)
    static let elementQueueLength: Int = 2

    static let restartButtonSize: CGSize = CGSize(width: 90, height: 30)
    static let restartButtonPos: CGPoint = CGPoint(x: 700, y: 600)
    static let textPos: CGPoint = CGPoint(x: 45, y: 15)
}
