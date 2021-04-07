//
//  HUDHPBar.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

class HUDHPBar: SKSpriteNode, PlayerHUDNode {

    var originalScale: CGFloat = 0.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let scale =  childNode(withName: "//fillBar")?.xScale {
            originalScale = scale
        }
    }

    func update(entityManager: EntityManager) {
        let maxHP = entityManager.currentSession.playerStats.maxHP
        let currentHP = entityManager
            .player?.component(ofType: HealthComponent.self)?.health ?? 0

        (childNode(withName: "//HP Label") as? SKLabelNode)?.text =
        "\(currentHP) / \(maxHP)"
        (childNode(withName: "//fillBar") as? SKSpriteNode)?.xScale = originalScale * currentHP / maxHP
    }

}
