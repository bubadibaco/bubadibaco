//
//  SleepView.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 25/07/24.
//

import SwiftUI

struct SleepView: View {
    var selectedAvatar: String

    var body: some View {
        NavigationView{
            ZStack {
                Image("bgRoomNight")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(selectedAvatar) is now sleeping. Good night!")
                        .font(.title)
                        .padding()
                    
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

                    NavigationLink(destination: GameViewControllerWrapper()) {
                        Text("Finish Story")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
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
