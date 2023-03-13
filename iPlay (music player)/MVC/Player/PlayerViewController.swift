//
//  PlayerViewController.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit

class PlayerViewController: UIViewController {
    //MARK: - Properties
    var queuePos: Int!
    var tracks: [Track]!
    var audio: Audio!
    var timer: Timer?
    //MARK: - UI Initialization
    private let playerView = PlayerView()
    //MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
}
    //MARK: - Configure Methods
extension PlayerViewController {
    
    private func configure() {
        setupVievs()
        constrtaintViews()
        setTargets()
        configureLabels()
        
    }
    
    private func configureLabels() {
        let track = tracks[queuePos]
        getImageCover()
        playerView.titleLabel.text = track.title
        playerView.authorLabel.text = track.artist
        playerView.currentTimeSlider.minimumValue = 0.0
        playerView.currentTimeSlider.maximumValue = Float(audio.player.duration)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func setupVievs() {
        [playerView].forEach {view.addView($0)}
    }
    
    private func constrtaintViews() {
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    //MARK: - Setting Targets
extension PlayerViewController {
    private func setTargets() {
        playerView.playPauseButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playerView.backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        playerView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        playerView.currentTimeSlider.addTarget(self, action: #selector(slideSlider), for: .valueChanged)
        playerView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}
//MARK: - Buttons Target Methods
@objc
extension PlayerViewController {
    func playButtonTapped() {
        if self.audio.player.isPlaying == true {
            self.audio.player.pause()
            playerView.playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            self.audio.player.play()
            playerView.playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }
    func backwardButtonTapped() {
        while queuePos > -1 {
            queuePos = queuePos - 1
            if queuePos == -1 {
                queuePos = tracks.count
                continue
            }
            audio.setUpPlayer(tracks[queuePos])
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
            playerView.removeFromSuperview()
            timer?.invalidate()
            configure()
            playerView.playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            break
        }
    }
    
    func forwardButtonTapped() {
        while queuePos < tracks.count {
            queuePos = queuePos + 1
            if queuePos == tracks.count {
                queuePos = tracks.startIndex - 1
                continue
            }
            audio.setUpPlayer(tracks[queuePos])
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
            playerView.removeFromSuperview()
            timer?.invalidate()
            configure()
            playerView.playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            break
        }
    }
    
    func slideSlider(_ sender: UISlider) {
        audio.player.stop()
        audio.player.prepareToPlay()
        audio.player.currentTime = TimeInterval(sender.value)
        audio.player.play()
    }
    
    func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    func updateTime() {
        playerView.currentTimeSlider.value = Float(audio.player.currentTime)
        playerView.currentTimeSlider.setValue(playerView.currentTimeSlider.value, animated: true)
        playerView.currentTimeLabel.text = "\(String.getDisplayedTimeString(for: audio.player.currentTime.rounded()))"
        playerView.remainingTimeLabel.text = "\(String.getDisplayedTimeString(for: audio.player.duration - audio.player.currentTime.rounded()))"
        
        if Int(audio.player.currentTime) >= Int(audio.player.duration) {
            forwardButtonTapped()
        }
    }
}
//MARK: - Audio Methods
extension PlayerViewController {
    private func getImageCover() {
        let track = tracks[queuePos]
        Task {
            playerView.albumView.image = await audio.getCoverImage(track)
            view.reloadInputViews()
        }
    }
}
