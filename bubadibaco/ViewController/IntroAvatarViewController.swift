//
//  IntroAvatarViewController.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import UIKit

class StoryViewController: UIViewController {

    var selectedAvatar: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        setupAvatarImage()
        setupRecapLabel()
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "livingroom")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    private func setupAvatarImage() {
        guard let selectedAvatar = selectedAvatar else { return }
        
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        if selectedAvatar == "Terry" {
            avatarImageView.image = UIImage(named: "dino")
        } else if selectedAvatar == "Trixie" {
            avatarImageView.image = UIImage(named: "unicorn")
        }
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupRecapLabel() {
        let recapLabel = UILabel()
        recapLabel.text = "Recap"
        recapLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        recapLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recapLabel)
        
        NSLayoutConstraint.activate([
            recapLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
