//
//  TextureUtilities.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit

class TextureUtilities {

    static func generateTextures(assetName: String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: assetName)
        var textures: [SKTexture] = []
        let count = atlas.textureNames.count
        for index in 1...(count - 1) {
            let textureName = assetName + String(index)
            let texture = CustomTexture.initialise(imageNamed: textureName)
            textures.append(texture)
        }
        return textures
    }

    static func convertToStringName(texture: SKTexture) -> String {
        let pattern = "'([^']*)'"
        let str = "\(texture)"
        guard let out = str.range(of: pattern, options: .regularExpression) else {
            return ""
        }
        return String(str[out])
    }
}
