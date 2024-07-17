//
//  AvatarIntro.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import SwiftUI

struct TextDisplayView: View {
    let introductionLines: [String]
    @State private var currentLineIndex: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                ZStack {
                    Image("speechBubble")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 1000, maxHeight: 500)
                        .clipped()
                    
                    Text(currentLine)
                        .font(.system(size: 52))
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: currentLineIndex)
                        .onTapGesture {
                            showNextLine()
                        }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.bottom, 50)
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
        }
    }
}

struct AvatarIntro: View {
    @State private var isShowingRoom = false
    
    var selectedAvatar: String
    let introductionText = """
    🎉 Welcome, Little Explorer! 🎉
    
    🌟 Meet [Avatar Name], your new best friend on this magical adventure! [Avatar Name] loves to explore, laugh, and discover new things every day, just like you!
    
    🏠 Together, you'll enter a cozy little house full of exciting tasks and fun surprises. 
    
    Each room has a special mission waiting for you. Are you ready to join [Avatar Name] on this wonderful journey? Let's go!
    
    🍎 First, let's head to the kitchen where you'll help [Avatar Name] find and enjoy a delicious snack. Can you discover what food [Avatar Name] wants?
    
    🚰 Next, it's time for a refreshing drink! [Avatar Name] is thirsty. Help them find their favorite drink!
    
    🎲 After that, it's playtime! [Avatar Name] loves to play with toys and games. Join the fun and see what toys [Avatar Name] loves the most!
    
    🛌 Finally, when the day is done, [Avatar Name] needs a good night's sleep. Help them get ready for bed by finding their bedtime objects.
    
    ✨ Each discovery you make brings you closer to becoming a true adventurer!
    
    So, grab your magic pencil and let's start this amazing journey with [Avatar Name]! Together, you'll explore and play!
    """
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
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
                        
                        TextDisplayView(introductionLines: replaceAvatarName(in: introductionText, with: selectedAvatar))
                            .padding()
                            .foregroundColor(.black)
                        
                    }
                    
                    Button(action: {
                        isShowingRoom = true
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
                                    .foregroundColor(.pink)
                            )
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(
                NavigationLink(
                    destination: Room(),
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

}

struct AvatarIntro_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIntro(selectedAvatar: "Terry")
    }
}
