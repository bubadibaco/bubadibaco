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

    func makeUIViewController(context: Context) -> PracticeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "practiceView") as? PracticeViewController else { return PracticeViewController()
        }
        vc.objectName = objectName
        return vc
    }

    func updateUIViewController(_ uiViewController: PracticeViewController, context: Context) {}
}
