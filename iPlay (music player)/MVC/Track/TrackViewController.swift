//
//  TrackViewController.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit

class TrackViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var playerVC: PlayerViewController!
    var tracks: [Track] = []
    var audio = Audio()
    var currentSongIndex = -2
    
    //MARK: - Lifecyycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
    //MARK: - TableView Delegate Methods
extension TrackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = tracks[indexPath.row]
        if playerVC == nil {
            playerVC = PlayerViewController()
            playerVC.queuePos = indexPath.row
            playerVC.audio = audio
            playerVC.tracks = tracks
            audio.setUpPlayer(track)
            currentSongIndex = indexPath.row
        } else {
            currentSongIndex = playerVC.queuePos!
            playerVC = nil
            if currentSongIndex == indexPath.row {
            } else {
                audio.player.stop()
                audio.setUpPlayer(track)
            }
            playerVC = PlayerViewController()
            playerVC.queuePos = indexPath.row
            playerVC.audio = audio
            playerVC.tracks = tracks
        }
            self.show(self.playerVC, sender: self)
    }
}
    //MARK: - TableView Datasource Methods
extension TrackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = tracks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(track.title) - \(track.artist)"

        content.secondaryText = "\(String.getDisplayedTimeString(for: track.duration))"
        content.textProperties.lineBreakMode = .byTruncatingTail
        content.textProperties.numberOfLines = 0
        content.textProperties.font = UIFont(name: "Helvetica-Light", size: 14) ?? UIFont()
        content.textProperties.color = .black
        
        content.secondaryTextProperties.font = UIFont(name: "Helvetica-Light", size: 14) ?? UIFont()
        content.secondaryTextProperties.color = .black
        
        cell.contentConfiguration = content
        return cell
    }
}

extension TrackViewController {
    
    private func configure() {
        fillUpSongs()
        configureDataSource()
        configureDelegates()
    }
    private func fillUpSongs() {
        Task {
            self.tracks = await audio.getTracks()
            self.tableView.reloadData()
        }
    }
    
    private func configureDataSource() {
        tableView.dataSource = self
    }
    
    private func configureDelegates() {
        tableView.delegate = self
    }
}
