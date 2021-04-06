//
//  playerHUD.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import GameplayKit

class PlayerHUD: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func updateHUD(entityManager: EntityManager) {
        guard let hpbar = childNode(withName: "//PlayerHP")?.childNode(withName: "//HPBar"),
              let levelLabel = childNode(withName: "//PlayerLevel")?
                .childNode(withName: "//HUDPlayerLevel") else {
            return
        }
        (hpbar as? PlayerHUDNode)?.update(entityManager: entityManager)
        (levelLabel as? PlayerHUDNode)?.update(entityManager: entityManager)
    }
}
