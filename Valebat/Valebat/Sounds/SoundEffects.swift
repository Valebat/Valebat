//
//  SoundEffects.swift
//  Valebat
//
//  Created by Aloysius Lim on 14/4/21.
//

import Foundation

struct SoundEffectData {
    var soundName: String
    var coolDown: TimeInterval
}

enum SoundEffect {
    case hit, laser

    func getSoundEffectData() -> SoundEffectData {
        switch self {
        case .hit:
            return SoundEffectData(soundName: "Hit", coolDown: 0.1)
        case .laser:
            return SoundEffectData(soundName: "LaserDamage", coolDown: 0.01)
        }
    }
}
