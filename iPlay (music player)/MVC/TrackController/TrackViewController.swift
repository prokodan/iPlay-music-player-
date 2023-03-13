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
    
    var tracks: [Track] = []
    
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
        tracks = Track.getTracks()
    }
    
    private func configureDataSource() {
        tableView.dataSource = self
    }
    
    private func configureDelegates() {
        tableView.delegate = self
    }
}
