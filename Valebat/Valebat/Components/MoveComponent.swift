//
//  This file is adapted from:
//
//  SpriteAgent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponent: GKComponent {

    var speed: CGFloat
    var nextPositions: [CGPoint] = []

    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }

    func hasNextPosition() -> Bool {
        !nextPositions.isEmpty
    }

    func getNextPosition() -> CGPoint? {
        nextPositions.removeFirst()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
