//
//  playerHUD.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import Foundation
import GameplayKit
class PlayerHUD: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Helloss")
    }
    func updateHUD() {
        guard let hpbar = childNode(withName: "//PlayerHP")?.childNode(withName: "//HPBar") else {
            return
        }
        (hpbar as? HUDHPBar)?.updateBar(maxHP: PlayerStatsManager.getInstance().maxHP, currentHP: EntityManager.getInstance().player?.component(ofType: HealthComponent.self)?.health ?? 0)
    }
}
