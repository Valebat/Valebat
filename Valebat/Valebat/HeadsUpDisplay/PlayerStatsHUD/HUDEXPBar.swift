//
//  HUDEXPBar.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit

class HUDEXPBar: SKSpriteNode {
    var originalScale: CGFloat = 0.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let scale =  childNode(withName: "//expFillBar")?.xScale {
            originalScale = scale
        }
    }

    func update(currentLevel: Int, currentEXP: Int, fullEXP: Int) {
        (childNode(withName: "//LevelLabel") as? SKLabelNode)?.text =
            "Level \(currentLevel)"
        (childNode(withName: "//expFillBar") as? SKSpriteNode)?.xScale = originalScale * CGFloat(currentEXP) / CGFloat(fullEXP)
    }

}
