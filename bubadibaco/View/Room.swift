//
//  Room.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 16/07/24.
//

import SwiftUI
import AVFoundation

struct Room: View {
    @State private var objectClicked: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isShowingAlphabets = false

    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                ZStack {
                    Image("bgRoom")

                    Image("ball")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(x:100, y:300)
                        .onTapGesture {
                            objectClicked = "ball"
                            playSound(named: "Ballsound")
                            isShowingAlphabets = true
                        }
                    
                    Image("cake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .offset(x:1800, y:0)
                        .onTapGesture {
                            objectClicked = "cake"
                            playSound(named: "Cakesound")
                            isShowingAlphabets = true
                        }
                    
                    Image("milk")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 150)
                        .offset(x:-1150, y: 30)
                        .onTapGesture {
                            objectClicked = "milk"
                            playSound(named: "MilkSound")
                            isShowingAlphabets = true
                        }
                    
                    Image("bed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 900)
                        .offset(x:-2150, y: 100)
                        .onTapGesture {
                            objectClicked = "bed"
                            playSound(named: "BedSound")
                            isShowingAlphabets = true
                        }
                }
                .navigationBarHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
                .background(
                    NavigationLink(
                        destination: Alphabets(objectName: objectClicked ?? ""),
                        isActive: $isShowingAlphabets,
                        label: { EmptyView() }
                    )
                )
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "m4a") else {
            print("Could not find the sound file for \(name).")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file for \(name).")
        }
    }
}

#Preview {
    Room()
}
