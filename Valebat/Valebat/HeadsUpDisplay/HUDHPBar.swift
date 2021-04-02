//
//  HUDHPBar.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import Foundation
import GameplayKit
class HUDHPBar: SKSpriteNode {

    var originalScale: CGFloat = 0.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let scale =  childNode(withName: "//fillBar")?.xScale {
            originalScale = scale
        }
    }

    func updateBar(maxHP: CGFloat, currentHP: CGFloat) {
        (childNode(withName: "//HP Label") as? SKLabelNode)?.text =
        "\(currentHP) / \(maxHP)"
        (childNode(withName: "//fillBar") as? SKSpriteNode)?.xScale = originalScale * currentHP / maxHP

    }

}
