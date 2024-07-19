//
//  GameViewController.swift
//  bubadibaco
//
//  Created by Michael Eko on 15/07/24.
//

import UIKit

class GameViewController: UIViewController {

    private var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "HomeBackground")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        setupLogoImageView()
        setupPlayButton()
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        print("Play button tapped")
        
        let chooseAvatarVC = ChooseAvatarViewController()
        chooseAvatarVC.modalPresentationStyle = .fullScreen
        present(chooseAvatarVC, animated: true, completion: nil)
    }
    
    private func setupLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    private func setupPlayButton() {
        let playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        playButton.backgroundColor = .systemPink
        playButton.layer.cornerRadius = 10
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(playButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
