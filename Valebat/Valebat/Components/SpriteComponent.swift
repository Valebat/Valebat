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

    static var idCounter: Double = 0.0
    private(set) var id: Double

    var cachedMoveComponent: MoveComponent?
    var isStatic: Bool
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat = 2, isStatic: Bool = true) {
        self.isStatic = isStatic
        self.id = SpriteComponent.idCounter
        SpriteComponent.idCounter += 1.0
        super.init()
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: size)
        node.position = position
        node.zPosition = zPosition
    }

    func getMoveComponent() -> MoveComponent? {
        if cachedMoveComponent == nil {
            cachedMoveComponent = entity?.component(conformingTo: MoveComponent.self)
        }
        return cachedMoveComponent
    }

    init(animatedTextures: [SKTexture], size: CGSize, position: CGPoint, isStatic: Bool = true, runForever: Bool = true) {
        self.isStatic = isStatic
        self.id = SpriteComponent.idCounter
        SpriteComponent.idCounter += 1.0
        super.init()
        node = SKSpriteNode(texture: animatedTextures[0], color: SKColor.white, size: size)
        node.position = position
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
            if let position = getMoveComponent()?.currentPosition {
                node.position = position
            }
            if let orientation = getMoveComponent()?.orientation {
                node.zRotation = orientation
            }
        }
    }
}
