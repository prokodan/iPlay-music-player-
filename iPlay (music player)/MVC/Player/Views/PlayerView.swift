//
//  PlayerView.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import UIKit
final class PlayerView: BaseView {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Close", for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    let albumView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.numberOfLines = .zero
        return label
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 13)
        label.numberOfLines = .zero
        return label
    }()
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 13)
        label.numberOfLines = .zero
        label.text = ""
        return label
    }()
    let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 13)
        label.numberOfLines = .zero
        label.text = ""
        return label
    }()
    let timeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    let currentTimeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemBlue
        slider.thumbTintColor = .clear
        return slider
    }()
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        return button
    }()
    let backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        return button
    }()
    let forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        return button
    }()
    let playerButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 25
        view.contentMode = .center
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVievs()
        constrtaintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupVievs() {
        super.setupViews()
        [closeButton, albumView, titleLabel, authorLabel, timeStackView, currentTimeSlider, playerButtonsStackView].forEach {addView($0)}
        
        [currentTimeLabel, remainingTimeLabel].forEach { timeStackView.addArrangedSubview($0) }
        
        [backwardButton, playPauseButton, forwardButton].forEach { playerButtonsStackView.addArrangedSubview($0) }
        
    }
    
    private func constrtaintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            albumView.centerXAnchor.constraint(equalTo: centerXAnchor),
            albumView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120),
            albumView.widthAnchor.constraint(equalTo: widthAnchor, constant: -80) ,
            albumView.heightAnchor.constraint(equalTo: albumView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: albumView.bottomAnchor, constant: 20),
            
            authorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            timeStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeStackView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 25),
            timeStackView.leadingAnchor.constraint(equalTo: albumView.leadingAnchor),
            timeStackView.trailingAnchor.constraint(equalTo: albumView.trailingAnchor),
            
            currentTimeSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTimeSlider.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 20),
            currentTimeSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            currentTimeSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            playerButtonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerButtonsStackView.topAnchor.constraint(equalTo: currentTimeSlider.bottomAnchor, constant: 25)
            
            
        ])
    }
}
