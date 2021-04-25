//
//  LaserSpell.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit
class LaserSpell: BaseInteractableEntity {

    var laserTexture = CustomTexture.initialise(imageNamed: "laser")
    let baseLength = ViewConstants.gridSize * 1.2
    let baseWidth = ViewConstants.gridSize * 30
    var baseSize = CGSize(width: ViewConstants.gridSize * 40, height: ViewConstants.gridSize * 5)
    var cachedSpriteNode: SKSpriteNode?

    init() {
        super.init(texture: laserTexture, size: baseSize, physicsType: .enemyAttack, position: CGPoint(x: 0, y: 0))
        cachedSpriteNode = component(ofType: SpriteComponent.self)?.node as? SKSpriteNode
        addComponent(DPSDamageComponent(damage: 0.0, type: .pure))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func resize(widthRatio: CGFloat, lengthRatio: CGFloat) {
        cachedSpriteNode?.scale(to: CGSize(width: baseWidth * widthRatio, height: baseLength * lengthRatio))
    }
    func changeOpacity(opacity: CGFloat) {
        cachedSpriteNode?.alpha = opacity
    }

    func rotate(angle: CGFloat) {
        cachedSpriteNode?.zRotation = angle
    }

    func reposition(origin: CGPoint, currentSizeRatio: CGFloat, currentAngle: CGFloat) {
        let newOrigin = CGVector(point: origin) + CGVector(angle: currentAngle) * currentSizeRatio * baseWidth / 2
        cachedSpriteNode?.position = CGPoint(x: newOrigin.dx, y: newOrigin.dy)
        rotate(angle: currentAngle)
        resize(widthRatio: currentSizeRatio, lengthRatio: currentSizeRatio)
    }
}
