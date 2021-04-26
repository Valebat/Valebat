//
//  BaseGameScene.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import SpriteKit
import GameplayKit

class BaseGameScene: SKScene {
    var inputHUDDisplay: UserInputNode!
    var playerHUDDisplay: PlayerHUD!

    var lastUpdateTime: TimeInterval = 0

    var userInputInfo: UserInputInfo = UserInputInfo()

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        setUpScene()
    }

    func setUpScene() {
        setUpUserInputHUD()
        setUpPlayerHUD()
    }

    func setUpPlayerHUD() {
        guard let refNode = SKReferenceNode(fileNamed: "PlayerHUD") else {
            return
        }
        addChild(refNode)
        refNode.position = CGPoint(x: size.width/2, y: size.height/2)
        guard let baseNode = refNode.childNode(withName: "//baseHUD") as? PlayerHUD else {
            return
        }
        playerHUDDisplay = baseNode
        baseNode.xScale = size.width / baseNode.frame.width
        baseNode.yScale = size.height / baseNode.frame.height
    }

    func setUpUserInputHUD() {
        inputHUDDisplay = UserInputNode(screenSize: self.size)
        addChild(inputHUDDisplay)
        inputHUDDisplay.userInputInfo = userInputInfo
    }
}
