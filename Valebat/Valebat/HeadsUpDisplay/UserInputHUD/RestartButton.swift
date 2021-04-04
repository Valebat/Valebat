//
//  RestartButton.swift
//  Valebat
//
//  Created by Sreyans Sipani on 4/4/21.
//

import SpriteKit

class RestartButton: SKSpriteNode {

    weak var userInputDelegate: UserInputDelegate?

    init() {
        super.init(texture: SKTexture(imageNamed: "elementbox"),
                   color: UIColor.brown, size: HUDConstants.restartButtonSize)
        self.isUserInteractionEnabled = false
        self.isHidden = true
        self.position = HUDConstants.restartButtonPos
        let restartText = SKLabelNode(text: "Restart")
        restartText.fontColor = UIColor.black
        restartText.fontSize = 20
//        restartText.position = HUDConstants.textPos
        self.addChild(restartText)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userInputDelegate?.restartClicked()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
