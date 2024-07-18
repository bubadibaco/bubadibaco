//
//  Room.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 16/07/24.
//

import SwiftUI
import AVFoundation

struct Room: View {
    @ObservedObject var roomData: RoomData
    @State private var objectClicked: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isShowingAlphabets = false

    var body: some View {
            NavigationView {
                ScrollView(.horizontal) {
                    ZStack {
                        Image("bgRoom")

                        ForEach(items, id: \.self) { item in
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .offset(getOffset(for: item))
                                .onTapGesture {
                                    objectClicked = item.name
                                    playSound(named: "\(item.name)Sound")
                                    isShowingAlphabets = true
                                }
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
    
    func getOffset(for item: Item) -> CGSize {
            switch item.name {
            case "ball":
                return CGSize(width: 100, height: 300)
            case "cake":
                return CGSize(width: 1800, height: 0)
            case "milk":
                return CGSize(width: -1150, height: 30)
            case "bed":
                return CGSize(width: -2150, height: 100)
            default:
                return CGSize.zero
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

