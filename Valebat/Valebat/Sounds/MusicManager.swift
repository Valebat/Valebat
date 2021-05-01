//
//  MusicManager.swift
//  Valebat
//
//  Created by Aloysius Lim on 1/5/21.
//

import Foundation
import AVFoundation
class MusicManager {
    private static var instance: MusicManager?
    static private var currentTrack: AVAudioPlayer?
    private static var currentTrackName: String?

    static func playBGM(trackData: TrackData) {
        if trackData.trackName == currentTrackName {
            return
        }
        currentTrack?.stop()
        guard let pathToSound = Bundle.main.path(forResource: trackData.trackName, ofType: "mp3") else {
            return
        }
        currentTrack = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathToSound))
        currentTrack?.numberOfLoops = -1
        currentTrack?.volume = trackData.volume
        currentTrack?.play()
        currentTrackName = trackData.trackName
    }

    static func playBGM(track: MusicTrack) {
        playBGM(trackData: track.getTrackData())
    }
}
