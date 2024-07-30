//
//  AvatarRecap.swift
//  bubadibaco
//
//  Created by Michael Eko on 16/07/24.
//

import SwiftUI
import AVFoundation

struct AvatarRecap: View {
    @ObservedObject var character: Character
    var selectedAvatar: String
    var selectedObjects: [String: String]
    @Binding var stories: [Story]
    @State private var hasSpoken = false
    @State private var navigateToSleep = false
    let primaryColor = Color("PrimaryColor")
    private let audioPlayerHelper = AudioPlayerHelper()
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationView {
            ZStack {
                Image("bgRoom")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 350, height: 200)
                            .shadow(radius: 10)
                        
                        VStack {
                            Text("Yay, thanks for helping me to eat \(selectedObjects["Eat"] ?? "eat"), drink some \(selectedObjects["Drink"] ?? "drink"), play \(selectedObjects["Play"] ?? "play"), and finally went to sleep in \(selectedObjects["Sleep"] ?? "sleep"). See you tomorrow!")
                                .frame(width: 300, height: 180)
                                .padding()
                        }
                    }
                    .onAppear {
                        if !hasSpoken {
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
                    } else if selectedAvatar == "Trixie" {
                        Image("unicorn")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: 400)
                            .onAppear {
                                print("Displaying image for \(character.name) (\(character.image))")
                            }
                    }
                    
                    NavigationLink(
                        destination: SleepView(selectedAvatar: selectedAvatar),
                        isActive: $navigateToSleep
                    ) {
                        EmptyView()
                    }

                    Button(action: goToSleep) {
                        Text("Sleep")
                            .foregroundColor(.white)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.horizontal, 100)
                            .background(
                                Capsule(style: .circular)
                                    .fill()
                                    .foregroundColor(primaryColor)
                            )
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            audioPlayerHelper.playSound(named: "avatar_recap")
        }
        .onDisappear {
            audioPlayerHelper.stopSound()
        }
    }
    
    private func goToSleep() {
        navigateToSleep = true
    }
}

//struct AvatarRecap_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarRecap(character: Character(name: "Terry", image: "dino"), selectedAvatar: "Terry", selectedObjects: ["Eat": "cake", "Drink": "juice", "Play": "ball", "Sleep": "bed"], stories: .constant([]))
//    }
//}
