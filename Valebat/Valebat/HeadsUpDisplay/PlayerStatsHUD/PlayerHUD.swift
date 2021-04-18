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

    func updateHUD(gameSession: BaseGameSession) {
        let stats = gameSession.playerStats
        updateHUD(currentHP: gameSession.entityManager.player?
                    .component(conformingTo: HealthComponent.self)?
                    .currentHealth ?? 0,
                  maxHP: stats.maxHP, playerLevel: stats.currentPlayerLevel,
                  currentEXP: stats.currentEXP,
                  floorLevel: gameSession.currentLevel + 1,
                  objectiveDescription: gameSession.objectiveManager.getDescription())
    }

    func updateHUD(currentHP: CGFloat, maxHP: CGFloat, playerLevel: Int,
                   currentEXP: Int, floorLevel: Int, objectiveDescription: String) {
        guard let hpbar = childNode(withName: "//PlayerHP")?.childNode(withName: "//HPBar"),
              let levelLabel = childNode(withName: "//PlayerLevel")?
                .childNode(withName: "//HUDPlayerLevel"),
              let expBar = childNode(withName: "//PlayerEXP")?.childNode(withName: "//EXPBar"),
              let objectiveLabel = childNode(withName: "//PlayerObjective")?
                .childNode(withName: "//HUDPlayerObjective") else {
            return
        }
        (hpbar as? HUDHPBar)?.update(currentHP: currentHP, maxHP: maxHP)
        (levelLabel as? HUDPlayerLevel)?.update(currentLevel: floorLevel)
        (expBar as? HUDEXPBar)?.update(currentLevel: playerLevel,
                                       currentEXP: currentEXP,
                                       fullEXP: PlayerStats.getEXPPerLevel(level: playerLevel))
        (objectiveLabel as? HUDPlayerObjective)?
            .update(objectiveDescription: objectiveDescription)
    }
}
