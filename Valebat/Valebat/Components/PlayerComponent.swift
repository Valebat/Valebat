//
//  PlayerComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

protocol PlayerComponent: BaseComponent {
    var player: PlayerEntity? { get set }
}
