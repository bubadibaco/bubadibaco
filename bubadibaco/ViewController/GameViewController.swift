//
//  GameViewController.swift
//  bubadibaco
//
//  Created by Michael Eko on 15/07/24.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    private var backgroundMusicPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "HomeBackground")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        setupPlayButton()
        playBackgroundMusic()
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        print("Play button tapped")
        
        let chooseAvatarVC = ChooseAvatarViewController()
        chooseAvatarVC.modalPresentationStyle = .fullScreen
        present(chooseAvatarVC, animated: true, completion: nil)
    }
    
    private func setupPlayButton() {
        let playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        playButton.backgroundColor = .systemBlue
        playButton.layer.cornerRadius = 10
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(playButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "mainMusic", withExtension: "mp3") else { return }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1 
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error)")
        }
    }
}
