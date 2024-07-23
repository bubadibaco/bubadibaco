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
    var selectedAvatar: String

    var body: some View {
        ZStack {
            Image("bgRoom")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if selectedAvatar == "Terry" {
                    Image("dino")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: 800)
                        .onAppear {
                            print("Displaying image for Terry (dino)")
                        }
                } else if selectedAvatar == "Trixie" {
                    Image("unicorn")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: 800)
                        .onAppear {
                            print("Displaying image for Trixie (unicorn)")
                        }
                }
                
                Button("Recap") {
                    let message = "Yay, you've done a good job in helping \(selectedAvatar) to eat a cake, drink some milk, play football, and finally went to bed. See you tomorrow!"
                    let utterance = AVSpeechUtterance(string: message)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    utterance.rate = 0.3
                    synthesizer.speak(utterance)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    AvatarRecap(selectedAvatar: "Terry")
}
