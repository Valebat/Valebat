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
}
