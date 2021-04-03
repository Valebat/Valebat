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
    static private var audioPlayer = [Int: AVAudioPlayer]()
    static private var soundCoolDowns = [String: Double]()
    private static let numberOfAudio = 30
    static private var currentCounter = 0

    static func update(seconds: TimeInterval) {
        for sound in soundCoolDowns.keys {
            if self.soundCoolDowns[sound] ?? 0 <= seconds {
                self.soundCoolDowns[sound] = nil
            } else {
                self.soundCoolDowns[sound]! -= seconds
            }
        }
    }

    static func playSound(soundName: String, cooldown: Double) {
        if soundCoolDowns[soundName] != nil {
            return
        }
        currentCounter += 1
        currentCounter %= numberOfAudio
        guard let pathToSound = Bundle.main.path(forResource: soundName, ofType: "wav") else {
           return
        }
        let url = URL(fileURLWithPath: pathToSound)
        audioPlayer[currentCounter] = try? AVAudioPlayer(contentsOf: url)
        audioPlayer[currentCounter]?.play()
        soundCoolDowns[soundName] = cooldown
    }
}
