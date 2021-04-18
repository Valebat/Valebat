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
        let texture = SKTexture(imageNamed: "restart-button")
        super.init(texture: texture, color: .brown, size: HUDConstants.restartButtonSize)
        self.isUserInteractionEnabled = true
        self.position = HUDConstants.restartButtonPos
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userInputDelegate?.restartClicked()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
