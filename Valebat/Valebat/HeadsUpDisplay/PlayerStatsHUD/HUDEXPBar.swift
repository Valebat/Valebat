//
//  HUDEXPBar.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit
class HUDEXPBar: SKSpriteNode, PlayerHUDNode {

    var originalScale: CGFloat = 0.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let scale =  childNode(withName: "//expFillBar")?.xScale {
            originalScale = scale
        }
    }

    func update(entityManager: EntityManager) {
        let exp = entityManager.currentSession.playerStats.currentEXP
        let currentLevel = entityManager.currentSession.playerStats.currentPlayerLevel
        let fullEXP = PlayerStats.getEXPPerLevel(level: currentLevel)
        (childNode(withName: "//LevelLabel") as? SKLabelNode)?.text =
            "Level \(currentLevel)"
        (childNode(withName: "//expFillBar") as? SKSpriteNode)?.xScale = originalScale * CGFloat(exp) / CGFloat(fullEXP)
    }

}