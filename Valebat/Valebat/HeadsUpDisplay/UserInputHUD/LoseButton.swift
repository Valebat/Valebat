//
//  LoseButton.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/4/21.
//

import SpriteKit

class LoseButton: SKSpriteNode, UserInputNodeProtocol {

    weak var userInputDelegate: UserInputDelegate?
    let restartButton: RestartButton = RestartButton()

    init() {
        let texture = SKTexture(imageNamed: "win-pop")
        super.init(texture: texture, color: .brown, size: HUDConstants.winButtonSize)
        self.isUserInteractionEnabled = false
        self.position = HUDConstants.winButtonHiddenPos
        self.addChild(restartButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func popUp() {
        self.run(SKAction.move(to: HUDConstants.winButtonPos, duration: 1))
    }

    func goBackDown() {
        self.position = HUDConstants.winButtonHiddenPos
    }
}
