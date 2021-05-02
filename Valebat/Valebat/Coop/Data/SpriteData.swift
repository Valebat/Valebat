//
//  SpriteData.swift
//  Valebat
//
//  Created by Zhang Yifan on 13/4/21.
//

import SpriteKit

struct SpriteData: Codable, Hashable {
    static let numberOfFields = 8
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

    static func convertToString(spriteData: Set<SpriteData>) -> String {
        spriteData.compactMap({ $0.convertToString() }).joined(separator: " ")
    }

    // Cannot allow empty space or commas in name field
    func convertToString() -> String? {
        if name.contains(",") || name.contains(" ") {
            return nil
        }

        var stringArr: [String] = []

        stringArr.append(idx.uuidString)
        stringArr.append(name)
        stringArr.append(String(width))
        stringArr.append(String(height))
        stringArr.append(String(xPos))
        stringArr.append(String(yPos))
        stringArr.append(String(zPos))
        stringArr.append(String(orientation))

        return stringArr.joined(separator: ",")
    }

    static func convertToSpriteData(dataString: String) -> [SpriteData] {
        dataString.split(separator: " ").compactMap({ SpriteData(dataString: String($0)) })
    }

    init? (dataString: String) {
        let fields = dataString.split(separator: ",").map({ String($0) })
        if fields.count != SpriteData.numberOfFields {
            return nil
        }
        guard let uid = UUID(uuidString: fields[0]),
              let width = Float(fields[2]),
              let height = Float(fields[3]),
              let xPos = Float(fields[4]),
              let yPos = Float(fields[5]),
              let zPos = Float(fields[6]),
              let orientation = Float(fields[7]) else {
            return nil
        }
        self.idx = uid
        self.name = fields[1]
        self.width = width
        self.height = height
        self.xPos = xPos
        self.yPos = yPos
        self.zPos = zPos
        self.orientation = orientation
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
}
