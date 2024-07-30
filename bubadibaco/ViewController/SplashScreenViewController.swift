//
//  SplashScreenViewController.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 26/07/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let audioPlayerHelper = AudioPlayerHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let logoImageView = UIImageView(image: UIImage(named: "PokaBoo"))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        audioPlayerHelper.playSound(named: "PukaBoo")

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.showMainApp()
        }
    }
    
    private func showMainApp() {
        let gameViewController = GameViewController()
        gameViewController.modalTransitionStyle = .crossDissolve
        gameViewController.modalPresentationStyle = .fullScreen
        present(gameViewController, animated: true, completion: nil)
    }
}
