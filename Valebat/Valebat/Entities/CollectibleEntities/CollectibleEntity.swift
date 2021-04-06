//
//  CollectibleEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

protocol CollectibleEntity: BaseEntity {
    func onCollect(player: PlayerEntity)
}
