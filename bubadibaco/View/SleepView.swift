//
//  SleepView.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 25/07/24.
//

//
//  SleepView.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 25/07/24.
//

import SwiftUI

struct SleepView: View {
    var selectedAvatar: String
    let primaryColor = Color("PrimaryColor")
    let backgroundColor = Color("BackgroundColor")

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack{
                        Image("speechBubble")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: 800)
                        
                        Text("\(selectedAvatar) is now sleeping. Good night!")
                            .font(.title)
                            .padding()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.2)
                            .padding()
                    }
                    
                    ZStack{
                        if selectedAvatar == "Terry" {
                            Image("dino")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(maxWidth: 400)
                        } else if selectedAvatar == "Trixie" {
                            Image("unicorn")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(maxWidth: 400)
                        }
                        
                        VStack{
                            Spacer()
                            Image("Mask")
                                .resizable()
                                .frame(maxWidth: 450)
                                .offset(x: 30, y: 65)
                            
                            Image("Blanket")
                                .resizable()
                                .frame(maxWidth: 400)
                        }
                    }

                    NavigationLink(destination: GameViewControllerWrapper()) {
                        Text("Finish Story")
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
                    .padding()
                    .onTapGesture {
                        StoryManager.shared.unlockNextStoryIfNeeded()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // No update needed
    }
}
