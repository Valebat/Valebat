//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

import SpriteKit
class Spell {
    var level: Double = 1.0
    var effects: [SpellEffectComponent.Type] = []
    var effectParams: [[Any]] = []
    var movement: SpellMovementComponent.Type = RegularMovementComponent.self

    static func buildEndAnimation() -> [SKTexture] {
        return TextureUtilities.generateTextures(assetName: "explosion") // getSpriteFolder(for: spell) +
    }
}
