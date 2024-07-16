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

    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                Image("bgRoom")
                Image("table")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                Image("ball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(x:900)
                    .onTapGesture {
                        objectClicked = "ball"
                        playSound(named: "Ballsound")

                    }
                Image("cake")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        objectClicked = "cake"
                        playSound(named: "Cakesound")

                    }
            }
        }
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
