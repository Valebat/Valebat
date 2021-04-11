//
//  HUDPlayerObjective.swift
//  Valebat
//
//  Created by Jing Lin Shi on 9/4/21.
//

import GameplayKit

class HUDPlayerObjective: SKSpriteNode, PlayerHUDNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(entityManager: EntityManager) {
        let objective = entityManager.objectiveManager.getDescription()
        (childNode(withName: "//Objective Label") as? SKLabelNode)?.text = objective
    }

}