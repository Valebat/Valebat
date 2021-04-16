//
//  HUDPlayerLevel.swift
//  Valebat
//
//  Created by Zhang Yifan on 4/4/21.
//

import GameplayKit

class HUDPlayerLevel: SKSpriteNode, PlayerHUDNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(gameSession: BaseGameSession) {
        let level = gameSession.currentLevel
        (childNode(withName: "//Level Label") as? SKLabelNode)?.text =
        "Level \(level + 1)"
    }

}
