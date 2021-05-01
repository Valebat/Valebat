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
    var zPos: Float
    var orientation: Float

    static func initialise(spNode: SKSpriteNode, idx: UUID) -> SpriteData? {
        guard let texture = spNode.texture as? CustomTexture,
              let textureName = texture.imageName else {
            return nil
        }

        let size = spNode.size
        let pos = spNode.position
        let orientation = spNode.zRotation

        return SpriteData(idx: idx, name: textureName, width: Float(size.width), height: Float(size.height),
                          xPos: Float(pos.x), yPos: Float(pos.y), zPos: Float(spNode.zPosition),
                          orientation: Float(orientation))
    }

    init(idx: UUID, name: String, width: Float, height: Float,
         xPos: Float, yPos: Float, zPos: Float, orientation: Float) {
        self.idx = idx
        self.name = name
        self.width = width
        self.height = height
        self.xPos = xPos
        self.yPos = yPos
        self.zPos = zPos
        self.orientation = orientation
    }

    init?(data: [String: Any]) {
        guard let idx = data["idx"] as? String,
              let name = data["name"] as? String,
              let width = data["width"] as? Float,
              let height = data["height"] as? Float,
              let xPos = data["xPos"] as? Float,
              let yPos = data["yPos"] as? Float,
              let zPos = data["zPos"] as? Float,
              let orientation = data["orientation"] as? Float else {
            return nil
        }
        guard let uid = UUID(uuidString: idx) else {
            return nil
        }
        self.idx = uid
        self.name = name
        self.width = width
        self.height = height
        self.xPos = xPos
        self.yPos = yPos
        self.zPos = zPos
        self.orientation = orientation
    }
}
