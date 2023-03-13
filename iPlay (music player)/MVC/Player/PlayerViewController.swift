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
    //MARK: - UI Initialization
    private let playerView = PlayerView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension PlayerViewController {
    
    private func configure() {
        setupVievs()
        constrtaintViews()
        
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
