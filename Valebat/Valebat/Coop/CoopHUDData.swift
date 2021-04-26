//
//  CoopHUDData.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/4/21.
//

import Foundation
import GameplayKit

struct CoopHUDData {
    var playerLevel: Int
    var currentLevel: Int
    var currentEXP: Int
    var objective: String
    var playercurrentHP = [String: CGFloat]()
    var maxHP: CGFloat

    init(session: BaseGameSession) {
        playerLevel = session.playerStats.currentPlayerLevel
        currentLevel = session.currentLevel
        currentEXP = session.playerStats.currentEXP
        objective = session.objectiveManager.getDescription()
        maxHP = session.playerStats.maxHP
    }

    init?(data: [String: Any]) {
        guard let playerLevel = data["playerLevel"] as? Int,
              let currentLevel = data["currentLevel"] as? Int,
              let currentEXP = data["currentEXP"] as? Int,
              let objective = data["objective"] as? String,
              let maxHP = data["maxHP"] as? Float else {
            return nil
        }

        var hpDict = [String: CGFloat]()
        if let playercurrentHP = data["playercurrentHP"] as? [String: Any] {
            for (idx, hpData) in playercurrentHP {
                guard let hpData = hpData as? Float else {
                    continue
                }
                hpDict[idx] = CGFloat(hpData)
            }
        }

        self.playerLevel = playerLevel
        self.currentLevel = currentLevel
        self.currentEXP = currentEXP
        self.objective = objective
        self.maxHP = CGFloat(maxHP)
        self.playercurrentHP = hpDict
    }
}
