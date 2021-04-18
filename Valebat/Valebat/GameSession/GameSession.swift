//
//  GameSession.swift
//  Valebat
//
//  Created by Aloysius Lim on 7/4/21.
//

import Foundation

class GameSession: BaseGameSession {
    
    override func loadGame() {
        if userConfig.isNewGame {
            persistenceManager?.loadInitialData()
        } else {
            persistenceManager?.load()
        }
    }
}
