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

    func update(gameSession: GameSession) {
        let maxHP = gameSession.playerStats.maxHP
        let currentHP = gameSession.entityManager
            .player?.component(ofType: HealthComponent.self)?.currentHealth ?? 0

        (childNode(withName: "//HP Label") as? SKLabelNode)?.text =
            "\(Int(ceil(currentHP))) / \(Int(maxHP))"
        (childNode(withName: "//fillBar") as? SKSpriteNode)?.xScale = originalScale * currentHP / maxHP
    }

}
