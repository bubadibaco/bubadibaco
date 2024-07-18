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
    @State private var items: [Item] = [
        Item(name: "cake", imageName: "cake", type: Task(name: "Eat cake", isDone: false)),
        Item(name: "ball", imageName: "ball", type: Task(name: "Play ball", isDone: false)),
        Item(name: "bed", imageName: "bed", type: Task(name: "Go to bed", isDone: false))
    ]
    
    @State private var ballClicked = false
    @State private var cakeClicked = false
    @State private var bedClicked = false
    @State private var isShowingAlphabets = false
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
        guard let dataAsset = NSDataAsset(name: name) else {
            print("Could not find the sound asset for \(name).")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file for \(name). Error: \(error.localizedDescription)")
        }
    }
}

