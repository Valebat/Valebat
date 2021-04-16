//
//  PlayerHUDNode.swift
//  Valebat
//
//  Created by Zhang Yifan on 4/4/21.
//

import SpriteKit

protocol PlayerHUDNode: SKSpriteNode {
    func update(gameSession: BaseGameSession)
}
