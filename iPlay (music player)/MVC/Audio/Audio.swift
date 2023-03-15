//
//  Audio.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit
import AVFoundation

class Audio {
    var player = AVAudioPlayer()
    /// Setting up player with the file name, from track model
    func setUpPlayer(_ track: Track) {
        player.stop()
        guard let path = Bundle.main.path(forResource: track.trackName, ofType: "mp3") else {return print("Wrong path")}
        let url = URL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    /// Get cover image from metadata from track model
    func getCoverImage(_ track: Track) async -> UIImage? {
        guard let path = Bundle.main.path(forResource: track.trackName, ofType: "mp3") else { return UIImage() }
        var coverImage: UIImage?
        let url = URL(fileURLWithPath: path)
        let asset = AVAsset(url: url)
        do {
            let metadata = try await asset.loadMetadata(for: AVMetadataFormat.id3Metadata)
            let coverMetadata = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: .commonIdentifierArtwork).first
            let imageData = try await coverMetadata?.load(.value) as? Data
            if let imageData = imageData {
                coverImage = UIImage(data: imageData)
            }
        } catch {
            print(error.localizedDescription)
        }
        return coverImage ?? UIImage(named: "defaultCover")
    }
    /// Get all .mp3 files from Main diretory
    func getTracks() async -> [Track] {
        var tracks = [Track]()
        let paths = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
        for path in paths {
            let url = URL(fileURLWithPath: path)
            let asset = AVAsset(url: url)
            let format = AVMetadataFormat.id3Metadata
            do {
                let a = try await asset.loadMetadata(for: format)
                let artist = try await a.first {$0.commonKey?.rawValue == AVMetadataKey.commonKeyArtist.rawValue }?.load(.value) as? String
                let title = try await a.first {$0.commonKey?.rawValue == AVMetadataKey.commonKeyTitle.rawValue }?.load(.value) as? String
                let album = try await a.first {$0.commonKey?.rawValue == AVMetadataKey.commonKeyAlbumName.rawValue}?.load(.value) as? String
                let fileName = url.lastPathComponent.components(separatedBy: ".mp3").first!
                let duration = try await asset.load(.duration).seconds
                
//                print(duration)
                tracks.append(Track(title: title ?? "defTitle",
                                    album: album ?? "defAlbum",
                                    artist: artist ?? "defArtist",
                                    trackName: fileName,
                                    duration: duration))
            } catch {
                print(error.localizedDescription)
            }
        }
        return tracks
    }
}


