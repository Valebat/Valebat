//
//  CustomTexture.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import SpriteKit

class CustomTexture: SKTexture {
    var imageName: String?

    static var cachedTextures = [String: CustomTexture]()

    static func initialise(imageNamed: String) -> CustomTexture {
        if let cachedTexture = cachedTextures[imageNamed] {
            return cachedTexture
        } else {
            let texture = self.init(imageNamed: imageNamed)
            texture.imageName = imageNamed
            cachedTextures[imageNamed] = texture
            return texture
        }
    }
}
