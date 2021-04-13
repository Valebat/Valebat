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

    static let outcomeButtonSize: CGSize = CGSize(width: 300, height: 300)
    static let outcomeButtonHiddenPos: CGPoint = CGPoint(x: 425, y: -200)
    static let outcomeButtonPos: CGPoint = CGPoint(x: 425, y: 300)

    static let restartButtonSize: CGSize = CGSize(width: 100, height: 60)
    static let restartButtonPos: CGPoint = CGPoint(x: 0, y: -40)
}
