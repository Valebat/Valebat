//
//  DeathComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

class DeathComponent: GKComponent {

    func onDeath() {
        if let entity = self.entity {
            EntityManager.getInstance().remove(entity)
        }
    }
}
