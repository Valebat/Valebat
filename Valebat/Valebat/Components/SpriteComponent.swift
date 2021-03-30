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

class SpriteComponent: GKSKNodeComponent {

    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat = 2) {
        super.init()
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: size)
        node.position = position
        node.zPosition = zPosition
    }

    init(animatedTextures: [SKTexture], size: CGSize, position: CGPoint) {
        super.init()
        node = SKSpriteNode(texture: animatedTextures[0], color: SKColor.white, size: size)
        node.position = position
        let animation = SKAction.repeatForever(SKAction.animate(with: animatedTextures, timePerFrame: 0.1))
        node.run(animation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
