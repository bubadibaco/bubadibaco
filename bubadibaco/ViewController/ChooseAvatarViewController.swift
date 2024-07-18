//
//  ChooseAvatarViewController.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import UIKit
import SwiftUI

class ChooseAvatarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chooseAvatarView = ChooseAvatar(characterData: CharacterData(characters: characters))
        let hostingController = UIHostingController(rootView: chooseAvatarView)
        
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
}
