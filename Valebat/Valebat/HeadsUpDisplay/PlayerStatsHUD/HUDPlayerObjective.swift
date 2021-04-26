//
//  HUDPlayerObjective.swift
//  Valebat
//
//  Created by Jing Lin Shi on 9/4/21.
//

import GameplayKit

class HUDPlayerObjective: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(objectiveDescription: String) {
        // let objective = gameSession.objectiveManager.getDescription()
        (childNode(withName: "//Objective Label") as? SKLabelNode)?.text = objectiveDescription
    }
}
