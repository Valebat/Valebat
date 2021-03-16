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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
