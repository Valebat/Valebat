//
//  CustomTexture.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import SpriteKit

class CustomTexture: SKTexture {
    var imageName: String?
    static func initialise(imageNamed: String) -> CustomTexture {
        let texture = self.init(imageNamed: imageNamed)
        texture.imageName = imageNamed
        return texture
    }
}
