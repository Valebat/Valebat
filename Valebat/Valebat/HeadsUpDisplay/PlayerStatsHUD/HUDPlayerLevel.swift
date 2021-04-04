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

    func update() {
        let level = PlayerStatsManager.getInstance().level
        let currentHP = EntityManager.getInstance()
            .player?.component(ofType: HealthComponent.self)?.health ?? 0

        (childNode(withName: "//Level Label") as? SKLabelNode)?.text =
        "\(currentHP) / \(level)"
    }

}
