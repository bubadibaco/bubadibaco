//
//  AvatarIntro.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import SwiftUI
import AVFoundation

struct TextDisplayView: View {
    let introductionLines: [String]
    @State private var currentLineIndex: Int = 0
    private let synthesizer = AVSpeechSynthesizer()
    @Binding var isButtonEnabled: Bool
    let primaryColor = Color("PrimaryColor")
   
    var body: some View {
        
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack(spacing:1) {
                    Text("tap to continue")
                        .italic()
                        .foregroundColor(.gray)
                    Text(currentLine)
                        .font(Font.custom("Cutiemollydemo", size: 30))
                   
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.8))
                                .shadow(radius: 10)
                        )
                        .transition(.opacity)
                        .animation(.easeInOut, value: currentLineIndex)
                        .onTapGesture {
                            showNextLine()
                        }
                        .onAppear {
                            speak(text: currentLine)
                        }
                }
                .padding()
                
                Spacer()
            }
            .padding(.top, 350)
            Button(action: {
                skipIntro()
            }) {
                Text("Skip")
                    .foregroundColor(.white)
                    .font(Font.custom("Cutiemollydemo", size: 20))
                    .font(.headline)
                    .bold()
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(primaryColor)
                    )
            }
        }
        .padding()
    }
    
    private var currentLine: String {
        if currentLineIndex < introductionLines.count {
            return introductionLines[currentLineIndex]
        } else {
            return "🎉 You're ready for the adventure! Let's go! 🎉"
        }
    }
    
    private func showNextLine() {
        if currentLineIndex < introductionLines.count - 1 {
            currentLineIndex += 1
            speak(text: currentLine)
        } else {
            isButtonEnabled = true
        }
    }
    
    private func skipIntro() {
        currentLineIndex = introductionLines.count - 1
        isButtonEnabled = true
    }
    
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

struct AvatarIntro: View {
    @State private var isShowingRoom = false
    @State private var isButtonEnabled = false
    let primaryColor = Color("PrimaryColor")
    private let audioPlayerHelper = AudioPlayerHelper()

    var selectedAvatar: String
    let introductionText = """
    🎉 Welcome, Little Explorer! 🎉
    
    🌟 I'm [Avatar Name], your new best friend on this magical adventure! I love to explore, laugh, and discover new things every day, just like you!
    
    🏠 Together, we'll enter a cozy little house full of exciting tasks and fun surprises.
    
    Each room has a special mission waiting for you. Are you ready to join me on this wonderful journey? Let's go!
    
    🍎 First, let's head to the kitchen where you'll help me find and enjoy a delicious snack.
    
    🚰 Next, it's time for a refreshing drink!.
    
    🎲 After that, it's playtime! I love to play with toys and games.
    
    🛌 Finally, when the day is done, I will need a good night's sleep. Help me get ready for bed by finding my bedtime objects.
    
    ✨ Each discovery you make brings you closer to becoming a true adventurer!
    
    So, grab your magic pencil and let's start this amazing journey with me! Together, we'll explore and play!
    """
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        if selectedAvatar == "Terry" {
                            Image("dino")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(maxWidth: 800)
                        } else if selectedAvatar == "Trixie" {
                            Image("unicorn")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(maxWidth: 800)
                        }
                        
                        TextDisplayView(introductionLines: replaceAvatarName(in: introductionText, with: selectedAvatar), isButtonEnabled: $isButtonEnabled)
                            .padding()
                            .foregroundColor(.black)
                            

                    }
                    
                    Button(action: {
                        isShowingRoom = true
                        if selectedAvatar == "Terry" {
                            audioPlayerHelper.playSound(named: "rawr_boy_sound")
                        }
                        else if selectedAvatar == "Trixie" {
                            audioPlayerHelper.playSound(named: "yeehaw_girl_sound")
                        }
                        
                    
                     


                    }) {
                        Text("Start")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.horizontal, 100)
                            .background(
                                Capsule(style: .circular)
                                    .fill()
                                    .foregroundColor(isButtonEnabled ? primaryColor : .gray)
                            )
                    }
                    .disabled(!isButtonEnabled)
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(
                NavigationLink(
                    destination: Room(roomData: RoomData(items: items), selectedAvatar: selectedAvatar, character: getCharacter(for: selectedAvatar)),
                    isActive: $isShowingRoom,
                    label: { EmptyView() }
                )
            )
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func replaceAvatarName(in text: String, with avatarName: String) -> [String] {
        let replacedText = text.replacingOccurrences(of: "[Avatar Name]", with: avatarName)
        return replacedText.components(separatedBy: "\n\n")
    }
    
    private func getCharacter(for avatarName: String) -> Character {
        if let character = characters.first(where: { $0.name == avatarName }) {
            return character
        } else {
            return characters[0]
        }
    }
}

struct AvatarIntro_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIntro(selectedAvatar: "Terry")
    }
}
