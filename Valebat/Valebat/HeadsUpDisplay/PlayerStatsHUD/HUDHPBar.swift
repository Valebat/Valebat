//
//  HUDHPBar.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

class HUDHPBar: SKSpriteNode {

    var originalScale: CGFloat = 0.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let scale =  childNode(withName: "//fillBar")?.xScale {
            originalScale = scale
        }
    }

    func update(currentHP: CGFloat, maxHP: CGFloat) {

        (childNode(withName: "//HP Label") as? SKLabelNode)?.text =
            "\(Int(ceil(currentHP))) / \(Int(maxHP))"
        (childNode(withName: "//fillBar") as? SKSpriteNode)?.xScale = originalScale * currentHP / maxHP
    }

}
