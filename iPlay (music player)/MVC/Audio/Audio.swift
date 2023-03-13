//
//  Audio.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import Foundation
import AVFoundation

class Audio {
    var player = AVAudioPlayer()
    
    func setUpPlayer(_ track: Track) {
        player.stop()
        guard let path = Bundle.main.path(forResource: track.trackName, ofType: "mp3") else {return print("Wrong path")}
        let url = URL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let playerItem = AVPlayerItem(url: url)
            
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
}
