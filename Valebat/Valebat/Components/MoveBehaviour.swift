//
//  This file is adapted from:
//
//  MonsterBehavior.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import GameplayKit
import SpriteKit

class MoveBehavior: GKBehavior {
    init(targetSpeed: Float, seek: GKAgent, avoid: [GKObstacle]) {
        super.init()
        if targetSpeed > 0 {
            setWeight(1, for: GKGoal(toReachTargetSpeed: targetSpeed))
            setWeight(2, for: GKGoal(toSeekAgent: seek))
            setWeight(100, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
        }
    }
}
