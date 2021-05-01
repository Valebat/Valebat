//
//  ClientScene.swift
//  Valebat
//
//  Created by Sreyans Sipani on 17/4/21.
//

import SpriteKit
import GameplayKit

class ClientScene: BaseGameScene {
    weak var viewController: ClientViewController?
    var spriteNodes = [UUID: SKSpriteNode]()
    var clientManager = ClientManager()

    var clientId: String?

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

        clientManager.getData()
        renderSprites()
        updateInputInfo()
        updateClientHUD()
        self.lastUpdateTime = currentTime

    }

    func updateClientHUD() {
        guard let playerHUDData = clientManager.coopHUDData,
              let currentHP = playerHUDData.playercurrentHP[clientId ?? ""] else {
            return
        }
        playerHUDDisplay.updateHUD(currentHP: currentHP,
                                   maxHP: playerHUDData.maxHP,
                                   playerLevel: playerHUDData.playerLevel,
                                   currentEXP: playerHUDData.currentEXP,
                                   floorLevel: playerHUDData.currentLevel + 1,
                                   objectiveDescription: playerHUDData.objective)
    }

    func renderSprites() {
        let sprites = clientManager.spritesData
        var newSpriteData = [UUID: SpriteData]()
        sprites.forEach({
            newSpriteData[$0.idx] = $0
        })
        var toRemove = [UUID]()
        for (uid, spriteNode) in spriteNodes {
            guard let sprite = newSpriteData[uid] else {
                toRemove.append(uid)
                continue
            }
            spriteNode.position = CGPoint(x: CGFloat(sprite.xPos), y: CGFloat(sprite.yPos))
            spriteNode.zPosition = CGFloat(sprite.zPos)
            spriteNode.zRotation = CGFloat(sprite.orientation)
            spriteNode.texture = CustomTexture.initialise(imageNamed: sprite.name)
            spriteNode.size = CGSize(width: CGFloat(sprite.width), height: CGFloat(sprite.height))
        }
        toRemove.forEach({
            spriteNodes[$0]?.removeFromParent()
            spriteNodes[$0] = nil
        })
        for (uid, sprite) in newSpriteData where spriteNodes[uid] == nil {
            let spriteNode = SKSpriteNode(texture: CustomTexture.initialise(imageNamed: sprite.name),
                                              color: SKColor.white,
                                              size: CGSize(width: CGFloat(sprite.width),
                                                           height: CGFloat(sprite.height)))
                spriteNode.position = CGPoint(x: CGFloat(sprite.xPos), y: CGFloat(sprite.yPos))
                spriteNode.zPosition = CGFloat(sprite.zPos)
                spriteNode.zRotation = CGFloat(sprite.orientation)
                addChild(spriteNode)
                spriteNodes[uid] = spriteNode
        }
    }

    func updateInputInfo() {
        guard let idx = clientId else {
            return
        }
        clientManager.gameNetworkManager?.updateUserInfo(playerId: idx,
                                                         userInputInfo: self.userInputInfo)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
