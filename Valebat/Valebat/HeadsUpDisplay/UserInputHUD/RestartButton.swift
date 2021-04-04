//
//  RestartButton.swift
//  Valebat
//
//  Created by Sreyans Sipani on 4/4/21.
//

import SpriteKit

class RestartButton: SKSpriteNode {

    init() {
        super.init(texture: SKTexture(imageNamed: "elementBox"),
                   color: UIColor.brown, size: HUDConstants.restartButtonSize)
        self.isUserInteractionEnabled = false
        self.isHidden = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        EntityManager.getInstance().restart()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

