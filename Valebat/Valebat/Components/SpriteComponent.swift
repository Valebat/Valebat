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

    init(entity: GKEntity, texture: SKTexture, size: CGSize) {
        super.init()
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: size)
    }

    init(entity: GKEntity, animatedTextures: [SKTexture], size: CGSize) {
        super.init()
        node = SKSpriteNode(texture: animatedTextures[0], color: SKColor.white, size: size)
        let animation = SKAction.repeatForever(SKAction.animate(with: animatedTextures, timePerFrame: 0.1))
        node.run(animation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
