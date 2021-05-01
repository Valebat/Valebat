//
//  CoopGameSession.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation

class CoopGameSession: BaseGameSession {
    var serverManager: ServerManager
    var room: Room?
    weak var gameNetworkManager: ServerGameNetworkManager?

    init(coopEntityManager: CoopEntityManager, userConfig: UserConfig, room: Room?) {
        self.room = room
        self.serverManager = ServerManager(coopEntityManager: coopEntityManager, room: room)
        super.init(entityManager: coopEntityManager, userConfig: userConfig)
        self.gameNetworkManager = serverManager.gameNetworkManager
    }

    func addClientPlayers() {
        guard let room = self.room else {
            return
        }
        self.room?.players.forEach({
            if $0 != room.hostId {
                serverManager.entityManager?.addClientPlayer(playerID: $0)
            }
        })
    }
}
