//
//  CoopGameSession.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation

class CoopGameSession: BaseGameSession {
    let roomManager: RoomManager

    init(coopEntityManager: CoopEntityManager, userConfig: UserConfig, roomManager: RoomManager) {
        self.roomManager = roomManager

        super.init(entityManager: coopEntityManager, userConfig: userConfig)

        self.coopManager = CoopManager(coopEntityManager: coopEntityManager)
    }

    func addClientPlayers() {
        print("called")
        print(roomManager.room?.players)
        roomManager.room?.players.forEach({ coopManager?.entityManager.addClientPlayer(playerID: $0) })
    }
}
