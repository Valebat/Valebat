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

    func updateHUD(gameSession: GameSession) {
        guard let hpbar = childNode(withName: "//PlayerHP")?.childNode(withName: "//HPBar"),
              let levelLabel = childNode(withName: "//PlayerLevel")?
                .childNode(withName: "//HUDPlayerLevel"),
              let expBar = childNode(withName: "//PlayerEXP")?.childNode(withName: "//EXPBar"),
              let objectiveLabel = childNode(withName: "//PlayerObjective")?
                .childNode(withName: "//HUDPlayerObjective") else {
            return
        }
        (hpbar as? PlayerHUDNode)?.update(gameSession: gameSession)
        (levelLabel as? PlayerHUDNode)?.update(gameSession: gameSession)
        (expBar as? PlayerHUDNode)?.update(gameSession: gameSession)
        (objectiveLabel as? PlayerHUDNode)?.update(gameSession: gameSession)
    }
}
