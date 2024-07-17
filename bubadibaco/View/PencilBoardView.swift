//
//  PencilBoardView.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 17/07/24.
//

import Foundation
import SwiftUI

struct PencilBoardView: UIViewControllerRepresentable {
    let objectName: String

    func makeUIViewController(context: Context) -> PencilBoardViewController {
        let viewController = PencilBoardViewController()
        viewController.objectName = objectName
        return viewController
    }

    func updateUIViewController(_ uiViewController: PencilBoardViewController, context: Context) {}
}
