//
//  TrackData.swift
//  Valebat
//
//  Created by Aloysius Lim on 1/5/21.
//

import Foundation

struct TrackData {
    var trackName: String
    var volume: Float
}

enum MusicTrack {
    case mainMenu, stage, boss

    func getTrackData() -> TrackData {
        switch self {
        case .mainMenu:
            return TrackData(trackName: "mainMenu", volume: 0.4)
        case .stage:
            return TrackData(trackName: "stage", volume: 0.4)
        case .boss:
            return TrackData(trackName: "boss", volume: 0.4)
        }
    }
}
