//
//  CGVectorExtension.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/2/21.
//

import CoreGraphics

extension CGVector {

    #if !(arch(x86_64) || arch(arm64))
    func sqrt(point: CGFloat) -> CGFloat {
        CGFloat(sqrtf(Float(point)))
    }
    #endif

    static func + (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }

    static func - (left: CGVector, right: CGVector) -> CGVector {
        CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }

    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    static func / (vector: CGVector, scalar: CGFloat) -> CGVector {
        CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }

    func dot(other: CGVector) -> CGFloat {
        self.dx * other.dx + self.dy * other.dy
    }

    func length() -> CGFloat {
        sqrt(dx * dx + dy * dy)
    }

    func normalized() -> CGVector {
        self / length()
    }

    func convertToPoint() -> CGPoint {
        CGPoint(x: dx, y: dy)
    }

    func calculateAngle() -> CGFloat {
        atan2(dy, dx)
    }
}
