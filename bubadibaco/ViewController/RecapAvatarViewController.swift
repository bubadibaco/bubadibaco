//
//  RecapAvatarViewController.swift
//  bubadibaco
//
//  Created by Michael Eko on 16/07/24.
//

import UIKit
import SwiftUI

class RecapAvatarViewController: UIViewController {
    var selectedAvatar: String = "defaultAvatar" 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let character = getCharacter(for: selectedAvatar)
        let recapAvatarView = AvatarRecap(character: character, selectedAvatar: selectedAvatar)
        let hostingController = UIHostingController(rootView: recapAvatarView)
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    private func getCharacter(for avatarName: String) -> Character {
            if let character = characters.first(where: { $0.name == avatarName }) {
                return character
            } else {
                return characters[0] // Default character if not found
            }
        }
}
