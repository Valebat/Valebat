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
    
    func loadFromFirebase() -> Set<SpriteData> {
        // TODO
        return Set()
    }
    
    func getChangedSprites(newSpritesData: Set<SpriteData>) -> Set<SpriteData> {
        var changedSprites = Set<SpriteData>()
        for sprite in spritesData {
            let newSprites = newSpritesData.filter( { $0.idx == sprite.idx } )
            if newSprites.count != 1 {
                // Error or doesn't exist
                continue
            } else {
                guard let newSprite = newSprites.first else {
                    continue
                }
                if newSprite != sprite {
                    changedSprites.insert(newSprite)
                }
            }
        }
        return changedSprites
    }
}
