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
    @State private var popupTodo = false
    @State private var isShowingAlphabets = false

    let frameSizes: [String: CGSize] = [
        "Ball": CGSize(width: 150, height: 150),
        "Cake": CGSize(width: 200, height: 150),
        "Milk": CGSize(width: 250, height: 150),
        "Bed": CGSize(width: 900, height: 600)
    ]

    let itemOffsets: [String: CGPoint] = [
        "Ball": CGPoint(x: 100, y: 300),
        "Cake": CGPoint(x: 1800, y: 0),
        "Milk": CGPoint(x: -1150, y: 30),
        "Bed": CGPoint(x: -2150, y: 100)
    ]

    @StateObject private var taskManager = TaskManager()
    
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
            .background(
                NavigationLink(
                    destination: Alphabets(objectName: objectClicked ?? "", isShowingAlphabets: $isShowingAlphabets),
                    isActive: $isShowingAlphabets,
                    label: { EmptyView() }
                )
            )
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

