//
//  CoopManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import GameplayKit

class CoopManager {
    var spritesData: Set<SpriteData> = Set()
    func saveSprites(spriteComponents: [GKComponent]) {
        spritesData = Set()
        for spriteComp in spriteComponents {
            guard let spriteComp = spriteComp as? SpriteComponent,
                  let spriteNode = spriteComp.node as? SKSpriteNode else {
                continue
            }
            if let spData = SpriteData.initialise(spNode: spriteNode, idx: spriteComp.idx) {
                spritesData.insert(spData)
            }
        }
    }
}
