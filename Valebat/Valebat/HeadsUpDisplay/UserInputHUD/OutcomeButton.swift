//
//  WinButton.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/4/21.
//

import SpriteKit

class OutcomeButton: SKSpriteNode, UserInputNodeProtocol {
    weak var userInputDelegate: UserInputDelegate?
    let restartButton: RestartButton = RestartButton()

    init() {
        let texture = SKTexture(imageNamed: "win-pop")
        super.init(texture: texture, color: .brown, size: HUDConstants.outcomeButtonSize)
        self.isUserInteractionEnabled = false
        self.position = HUDConstants.outcomeButtonHiddenPos
        self.addChild(restartButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func popUp() {
        self.run(SKAction.move(to: HUDConstants.outcomeButtonPos, duration: 1))
    }

    func goBackDown() {
        self.position = HUDConstants.outcomeButtonHiddenPos
    }
}
