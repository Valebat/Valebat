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
    case mainMenu

    func getTrackData() -> TrackData {
        switch self {
        case .mainMenu:
            return TrackData(trackName: "mainMenu", volume: 1.0)
        }
    }
}
