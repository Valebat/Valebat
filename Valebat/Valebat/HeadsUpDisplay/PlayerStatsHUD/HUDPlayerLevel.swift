//
//  HUDPlayerLevel.swift
//  Valebat
//
//  Created by Zhang Yifan on 4/4/21.
//

import GameplayKit

class HUDPlayerLevel: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(currentLevel: Int) {
        (childNode(withName: "//Level Label") as? SKLabelNode)?.text =
        "Level \(currentLevel)"
    }

}
