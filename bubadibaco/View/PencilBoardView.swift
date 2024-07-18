//
//  PencilBoardView.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 17/07/24.
//

import Foundation
import SwiftUI

struct PencilBoardView: UIViewControllerRepresentable {
    @Binding var showPencilBoard: Bool
    let objectName: String

    func makeUIViewController(context: Context) -> PracticeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "practiceView") as? PracticeViewController else { return PracticeViewController() }
        vc.objectName = objectName
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: PracticeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PracticeViewControllerDelegate {
        
        var parent: PencilBoardView
        
        init(_ parent: PencilBoardView) {
            self.parent = parent
        }
       
        
        func drawingDone(score: Double) {
            if score > 0 {
                parent.showPencilBoard = false
            }
        }
    }
}
