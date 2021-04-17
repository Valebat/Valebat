//
//  SpriteData.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import SpriteKit

struct SpriteData: Codable, Hashable {
    var idx: UUID
    var name: String
    var width: Float
    var height: Float
    var xPos: Float
    var yPos: Float
    var orientation: Float

    static func initialise(spNode: SKSpriteNode, idx: UUID) -> SpriteData? {
        guard let texture = spNode.texture as? CustomTexture,
              let textureName = texture.imageName else {
            return nil
        }

        let size = texture.size()
        let pos = spNode.position
        let orientation = spNode.zRotation

        return SpriteData(idx: idx, name: textureName, width: Float(size.width), height: Float(size.height),
                          xPos: Float(pos.x), yPos: Float(pos.y), orientation: Float(orientation))
    }
}
