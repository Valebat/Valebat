//
//  PlayerComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import Foundation
import GameplayKit

protocol PlayerComponent: GKComponent {
    var player: Player? { get set }
}
