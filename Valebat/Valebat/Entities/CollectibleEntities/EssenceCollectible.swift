//
//  EssenceCollectible.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit

class EssenceCollectible: GKEntity, CollectibleEntity {

    var type: ElementType
    var amount: Int
    func onCollect(player: Player) {
        player.essenceManager.addEssence(type: type, amount: amount)
    }

    init(type: ElementType, amount: Int) {
        self.type = type
        self.amount = amount
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
