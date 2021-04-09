//
//  TextureUltilities.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit

class TextureUltilties {

    static func generateTextures(assetName: String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: assetName)
        var textures: [SKTexture] = []
        let count = atlas.textureNames.count
        for index in 1...(count - 1) {
            let textureName = assetName + String(index)
            textures.append(atlas.textureNamed(textureName))
        }
        return textures
    }
}
