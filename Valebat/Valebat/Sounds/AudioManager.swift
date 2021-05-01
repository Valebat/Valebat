//
//  AudioManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import Foundation
import AVFoundation

class AudioManager {
    private static var instance: AudioManager?
    static private var audioPlayers = [String: AVAudioPlayer]()
    static private var soundCoolDowns = [String: Double]()

    static func update(seconds: TimeInterval) {
        for sound in soundCoolDowns.keys {
            if self.soundCoolDowns[sound] ?? 0 <= seconds {
                self.soundCoolDowns[sound] = nil
            } else {
                self.soundCoolDowns[sound]! -= seconds
            }
        }
    }

    private static func getAudioPlayer(soundName: String) -> AVAudioPlayer? {
        if audioPlayers[soundName] == nil {
            guard let pathToSound = Bundle.main.path(forResource: soundName, ofType: "wav") else {
                return nil
            }
            guard let newPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathToSound)) else {
                return nil
            }
            audioPlayers[soundName] = newPlayer
        }
        return audioPlayers[soundName]
    }

    static func playSound(soundData: SoundEffectData) {
        if soundCoolDowns[soundData.soundName] != nil {
            return
        }
        let player = getAudioPlayer(soundName: soundData.soundName)
        player?.volume = soundData.volume
        player?.play()
        soundCoolDowns[soundData.soundName] = soundData.coolDown
    }

    static func playSound(soundEffect: SoundEffect) {
        playSound(soundData: soundEffect.getSoundEffectData())
    }
}
