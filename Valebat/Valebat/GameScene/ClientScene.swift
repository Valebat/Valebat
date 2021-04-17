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

    override init(size: CGSize) {
        super.init(size: size)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        AudioManager.update(seconds: deltaTime)

        renderSprites(sprites: loadSpriteData())

        self.lastUpdateTime = currentTime

    }

    // Gives sprites which have changed
    func loadSpriteData() -> Set<SpriteData> {
        // TODO: Fetch from coop manager
        let sampleSprite = SpriteData(idx: UUID(), name: "character",
                                      width: Float(ViewConstants.playerWidth),
                                      height: Float(ViewConstants.playerHeight),
                                      xPos: 100.0, yPos: 100.0, orientation: 0.0)
        return [sampleSprite]
    }

    func renderSprites(sprites: Set<SpriteData>) {
        self.removeAllChildren()
        super.setUpScene()
        for sprite in sprites {
            let spriteNode = SKSpriteNode(texture: CustomTexture.initialise(imageNamed: sprite.name),
                                          color: SKColor.white,
                                          size: CGSize(width: CGFloat(sprite.width),
                                                       height: CGFloat(sprite.height)))
            spriteNode.position = CGPoint(x: CGFloat(sprite.xPos), y: CGFloat(sprite.yPos))
            spriteNode.zRotation = CGFloat(sprite.orientation)
            addChild(spriteNode)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
