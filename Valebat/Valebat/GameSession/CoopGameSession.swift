//
//  CoopGameSession.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import Foundation

class CoopGameSession: BaseGameSession {
    override init(entityManager: EntityManager, userConfig: UserConfig) {
        super.init(entityManager: entityManager, userConfig: userConfig)

        // TODO: can add conditional creation of coopmanager base on userconfig
        self.coopManager = CoopManager()
    }
}
