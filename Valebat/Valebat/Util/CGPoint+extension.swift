//
//  CGPointExtension.swift
//  Valebat
//
//  Created by Zhang Yifan on 12/2/21.
//

import CoreGraphics

extension CGPoint {

    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x / scalar, y: point.y / scalar)
    }

    #if !(arch(x86_64) || arch(arm64))
    func sqrt(point: CGFloat) -> CGFloat {
        CGFloat(sqrtf(Float(point)))
    }
    #endif

    func length() -> CGFloat {
        sqrt(x * x + y * y)
    }

    func normalized() -> CGPoint {
        self / length()
    }

    func convertToVector() -> CGVector {
        CGVector(dx: x, dy: y)
    }

    func calculateAngle() -> CGFloat {
        atan2(y, x)
    }

}
