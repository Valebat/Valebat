//
//  GameSession.swift
//  Valebat
//
//  Created by Aloysius Lim on 7/4/21.
//

import Foundation

class GameSession {
    var playerStats: PlayerStats
    var currentLevel: Int

    init() {
        playerStats = PlayerStats()
        currentLevel = 0
    }
}
