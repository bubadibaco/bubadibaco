//
//  ChooseAvatar.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import SwiftUI

struct ChooseAvatar: View {
    @ObservedObject var characterData: CharacterData
    
    @State private var isShowingAvatar = false
    @State private var selectedAvatar: String = ""
    @State private var animatingCharacter: String? = nil
    @State private var characterTapped = [String: Bool]()
    @State private var isAnimating = [String: Bool]()
    
    @Environment(\.presentationMode) var presentationMode
    
    let primaryColor = Color("PrimaryColor")
    private let audioPlayerHelper = AudioPlayerHelper()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Choose Avatar")
                        .padding()
                        .bold()
                        .foregroundColor(primaryColor)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        ForEach(characterData.characters, id: \.self) { character in
                            VStack {
                                Button(action: {
                                    isShowingAvatar = true
                                    selectedAvatar = character.name
                                }) {
                                    VStack {
                                        Text("\(character.name)")
                                            .foregroundColor(.white)
                                            .font(.largeTitle)
                                            .bold()
                                            .padding(.vertical, 20)
                                            .padding(.horizontal, 100)
                                            .background(
                                                Capsule(style: .circular)
                                                    .fill()
                                                    .foregroundColor(primaryColor)
                                            )
                                        Image(character.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 400, height: 400)
                                            .offset(y: animatingCharacter == character.name ? -20 : 0)
                                            .animation(
                                                animatingCharacter == character.name ?
                                                Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) :
                                                        .default
                                            )
                                            .onTapGesture {
                                                if characterTapped[character.name] == true {
                                                    // Second tap, navigate to AvatarIntro
                                                    isShowingAvatar = true
                                                    selectedAvatar = character.name
                                                    // Reset animation state after proceeding
                                                    animatingCharacter = nil
                                                    characterTapped[character.name] = false
                                                    if character.name == "Terry"{
                                                        audioPlayerHelper.playSound(named: "rawr_boy_sound")
                                                    }
                                                    else if character.name == "Trixie" {
                                                        audioPlayerHelper.playSound(named: "yeehaw_girl_sound")
                                                    }
                                                } else {
                                                    // First tap, start animation
                                                    characterTapped[character.name] = true
                                                    animatingCharacter = character.name
                                                    // Ensure other animations are stopped
                                                    for key in characterTapped.keys where key != character.name {
                                                        if characterTapped[key] == true {
                                                            characterTapped[key] = false
                                                            isAnimating[key] = false
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(
                NavigationLink(
                    destination: AvatarIntro(selectedAvatar: selectedAvatar),
                    isActive: $isShowingAvatar,
                    label: { EmptyView() }
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}
