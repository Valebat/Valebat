//
//  StarProjectiles.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit
class StarProjectile: EnemyBasicAttackEntity {

    override class func getImage(type: BasicType) -> String {
        switch type {
        case .water:
            return "bluestar"
        case .earth:
            return "greenstar"
        case .fire:
            return  "redstar"
        default:
            return "purestar"
        }
    }
    override class func getSize() -> CGFloat {
        return 0.5
    }

    override class func getSpriteTexture(damageType: BasicType) -> SKTexture {
        return CustomTexture.initialise(imageNamed: Self.getImage(type: damageType))
    }

    override func addAnimation(damageType: BasicType) { }
}
