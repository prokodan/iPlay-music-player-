//
//  Track.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import Foundation

struct Track {
    let title: String
    let album: String
    let artist: String
    let trackName: String
    let duration: Double
}

extension Track {
    static func getTracks() -> [Track] {
            var tracks = [Track]()
    
            [Track(title: "Sympathy For The Devil",
                   album: "Beggars Banquet",
                   artist: "Rolling Stones",
                   trackName: "Rolling Stones - Sympathy For The Devil",
                   duration: 0.0),
             Track(title: "Get It On",
                    album: "Electric Warrior",
                    artist: "T. Rex",
                    trackName: "T. Rex - Get It On",
                    duration: 0.0),
             Track(title: "Take On Me",
                    album: "Take On Me 2017 Acoustic",
                    artist: "a-ha",
                    trackName: "a-ha - Take On Me 2017 Acoustic",
                   duration: 0.0)
    
            ].forEach { tracks.append($0)}
    
    
            return tracks
        }
}
