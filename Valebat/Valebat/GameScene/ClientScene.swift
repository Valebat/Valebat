//
//  ClientScnee.swift
//  Valebat
//
//  Created by Sreyans Sipani on 17/4/21.
//

import SpriteKit
import GameplayKit

class ClientScene: BaseGameScene {
    weak var viewController: ClientViewController?

    var spriteNodes = [SKSpriteNode]()
    var clientManager = ClientManager()

    override init(size: CGSize) {
        super.init(size: size)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        print("update call")

        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        AudioManager.update(seconds: deltaTime)

        clientManager.getSpriteData()
        renderSprites()

        self.lastUpdateTime = currentTime

    }

    func renderSprites() {
        let sprites = clientManager.spritesData
        spriteNodes.forEach({ $0.removeFromParent() })
        spriteNodes = [SKSpriteNode]()
        for sprite in sprites {
            let spriteNode = SKSpriteNode(texture: CustomTexture.initialise(imageNamed: sprite.name),
                                          color: SKColor.white,
                                          size: CGSize(width: CGFloat(sprite.width),
                                                       height: CGFloat(sprite.height)))
            spriteNode.position = CGPoint(x: CGFloat(sprite.xPos), y: CGFloat(sprite.yPos))
            spriteNode.zPosition = CGFloat(sprite.zPos)
            spriteNode.zRotation = CGFloat(sprite.orientation)
            addChild(spriteNode)
            spriteNodes.append(spriteNode)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
