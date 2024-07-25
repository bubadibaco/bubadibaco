//
//  AvatarRecap.swift
//  bubadibaco
//
//  Created by Michael Eko on 16/07/24.
//

import SwiftUI
import AVFoundation

let synthesizer = AVSpeechSynthesizer()

struct AvatarRecap: View {
    @ObservedObject var character: Character
    var selectedAvatar: String
    var selectedObjects: [String: String]
    @Binding var stories: [Story]
    @State private var hasSpoken = false
    @State private var navigateToGameViewController = false

    var body: some View {
        ZStack {
            Image("bgRoom")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Image("speechBubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 200)
                    VStack {
                        Text("Yay, you've done a good job in helping \(selectedAvatar) to eat \(selectedObjects["Eat"] ?? "eat"), drink some \(selectedObjects["Drink"] ?? "drink"), play \(selectedObjects["Play"] ?? "play"), and finally went to sleep in \(selectedObjects["Sleep"] ?? "sleep"). See you tomorrow!")
                            .frame(width: 350, height: 180)
                            .padding()
                    }
                }
                .onAppear {
                    if !hasSpoken {
                        speakMessage()
                        hasSpoken = true
                    }
                }
                
                if selectedAvatar == "Terry" {
                    Image("dino")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: 400)
                        .onAppear {
                            print("Displaying image for Terry (dino)")
                        }
                        .onTapGesture {
                            speakMessage()
                        }
                } else if selectedAvatar == "Trixie" {
                    Image("unicorn")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: 400)
                        .onAppear {
                            print("Displaying image for \(character.name) (\(character.image))")
                        }
                        .onTapGesture {
                            speakMessage()
                        }
                }
                
                NavigationLink(destination: GameViewControllerWrapper(), isActive: $navigateToGameViewController) {
                    EmptyView()
                }
                
                Button(action: finishStory) {
                    Text("Finish")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    private func speakMessage() {
        let message = "Yay, you've done a good job in helping \(selectedAvatar) to \(selectedObjects["Eat"] ?? "eat"), \(selectedObjects["Drink"] ?? "drink"), \(selectedObjects["Play"] ?? "play"), and finally went to \(selectedObjects["Sleep"] ?? "sleep"). See you tomorrow!"
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.3
        synthesizer.speak(utterance)
    }
    
    private func finishStory() {
        if let index = stories.firstIndex(where: { $0.name == "Terry and Trixie" }) {
            stories[index].isUnlocked = true
            if index + 1 < stories.count {
                stories[index + 1].isUnlocked = true
            }
        }
        navigateToGameViewController = true
    }
}

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        if let navigationController = uiViewController.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
}
