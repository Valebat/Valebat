//
//  This file is adapted from:
//
//  SpriteComponent.swift
//  DinoDefense
//
//  Created by Toby Stephens on 20/10/2015.
//  Copyright © 2015 razeware. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKSKNodeComponent, MovementCachable {
    private(set) var idx: UUID

    var cachedMoveComponent: MoveComponent?
    var isStatic: Bool
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat = 2, isStatic: Bool = true) {
        self.isStatic = isStatic
        self.idx = UUID()
        super.init()
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: size)
        node.position = position
        node.zPosition = zPosition
    }

    func animate(with animatedTextures: [SKTexture], runForever: Bool) {
        let animation: SKAction
        if runForever {
            animation = SKAction.repeatForever(SKAction.animate(with: animatedTextures, timePerFrame: 0.1))
        } else {
            animation = SKAction.animate(with: animatedTextures, timePerFrame: 0.1)
        }
        node.run(animation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        if !isStatic {
            if let position = getCurrentPosition() {
                node.position = position
            }
            if let orientation = getMovementComponent()?.orientation {
                node.zRotation = orientation
            }
        }
    }
}
