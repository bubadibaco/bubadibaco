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
    @State private var popupTodo = false
    @State private var isShowingAlphabets = false
    @State private var items: [Item] = [
        Item(name: "cake", imageName: "cake", type: Task(name: "Eat cake", isDone: false)),
        Item(name: "ball", imageName: "ball", type: Task(name: "Play ball", isDone: false)),
        Item(name: "bed", imageName: "bed", type: Task(name: "Go to bed", isDone: false)),
        Item(name: "milk", imageName: "milk", type: Task(name: "Drink milk", isDone: false))
        
    ]
    
    @State private var ballClicked = false
    @State private var cakeClicked = false
    @State private var bedClicked = false
    @State private var milkClicked = false

    @StateObject private var taskManager = TaskManager()
    
    
    var body: some View {
        var cakeItem = items.first(where: { $0.imageName == "cake" })
        var ballItem = items.first(where: { $0.imageName == "ball" })
        var bedItem = items.first(where: { $0.imageName == "bed" })
        var milkItem = items.first(where: { $0.imageName == "milk" })
        
        NavigationView {
            ScrollView(.horizontal) {
                ZStack {
                    Image("bgRoom")
                    
                    ballItem?.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(x: 900)
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
                    
                    milkItem?.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(x:-1150, y: 30)
                        .onTapGesture {
                            objectClicked = "milk"
                            playSound(named: "Ballsound")
                            isShowingAlphabets = true
                        }
                    
                    bedItem?.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                        .offset(x:-500)
                        .onTapGesture {
                            if taskManager.areTasksDone(names: ["Eat cake", "Play ball", "Drink milk"]) {
                                playSound(named: "Bedsound")
                                isShowingAlphabets = true
                                let taskball = taskManager.tasks[1]
                                let taskcake = taskManager.tasks[0]
                                let taskmilk = taskManager.tasks[2]


                                print(taskball.isDone)
                                print(taskcake.isDone)

                                print(taskmilk.isDone)

                                
                            } else {
                                print("cannot")
                            }
                        }
                    
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if popupTodo {
                                Todo()
                            }
                            Button(action: {
                                popupTodo.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.red)
                            }
                            .padding()
                        }
                    }
                }
                .navigationBarHidden(true)
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
            .edgesIgnoringSafeArea(.all)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func updateBallTask(isDone: Bool) {
        taskManager.updateTask(name: "Play ball", isDone: isDone)
    }
    
    func updateCakeTask(isDone: Bool) {
        taskManager.updateTask(name: "Eat cake", isDone: isDone)
    }
    
    func updateBedTask(isDone: Bool) {
        taskManager.updateTask(name: "Go to bed", isDone: isDone)
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

#Preview {
    Room()
}
