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
    @State private var items: [Item] = [
            Item(name: "cake", imageName: "cake", type: Task(name: "Eat cake", isDone: false)),
            Item(name: "ball", imageName: "ball", type: Task(name: "Play ball", isDone: false)),
            Item(name: "bed", imageName: "bed", type: Task(name: "Go to bed", isDone: false))

        ]
    
    @State private var ballClicked = false
    @State private var cakeClicked = false
    @State private var bedClicked = false


    
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        
        var cakeItem = items.first(where: { $0.imageName == "cake" })
        var ballItem = items.first(where: { $0.imageName == "ball" })
        var bedItem = items.first(where: { $0.imageName == "bed" })
        

        
        GeometryReader { geometry in
             ZStack {
                 ScrollView(.horizontal) {
                     ZStack {
                         Image("bgRoom")
                         bedItem?.image
                             .resizable()
                             .scaledToFit()
                             .frame(width: 500, height: 500)
                             .offset(x:-500)
                             .onTapGesture {
                                 if taskManager.areTasksDone(names: ["Eat cake", "Play ball"]) {
                                                                     bedClicked.toggle()
                                                                     playSound(named: "Bedsound")
                                                                     bedItem?.type.isDone = true
                                                                     taskManager.updateTask(name: "Go to bed", isDone: true)
                                                                 }
                                 else {
                                     print("cannot")
                                 }
                             }
                             .overlay(
                                Group {
                                    if bedClicked {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .frame(width: 200, height: 200)
                                                .padding(10)
                                            Button(action: {
                                                bedClicked = false
                                                bedItem?.type.isDone = true
                                                updateBedTask(isDone: true)
                                             
                                            }) {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.black)
                                            }
                                        } .offset(x:-500)



                                    }
                                }
                             )
                         Image("table")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 500, height: 500)
                         ballItem?.image                             
                             .resizable()
                             .scaledToFit()
                             .frame(width: 200, height: 200)
                             .offset(x: 900)
                             .onTapGesture {
                                 objectClicked = "ball"
                                 playSound(named: "Ballsound")
                                 ballClicked.toggle()
                             }
                             .overlay(
                                Group {
                                    if ballClicked {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .frame(width: 200, height: 200)
                                                .padding(10)
                                            Button(action: {
                                                ballClicked = false
                                                ballItem?.type.isDone = true
                                                updateBallTask(isDone: true)
                                             
                                            }) {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.black)
                                            }
                                        }.offset(x: 800)


                                    }
                                }
                             )
                         
                         cakeItem?.image
                             .resizable()
                             .scaledToFit()
                             .frame(width: 100, height: 100)
                             .onTapGesture {
                                 objectClicked = "cake"
                                 playSound(named: "Cakesound")
                                 cakeItem?.type.isDone = true
                                 cakeClicked.toggle()
                             }
                             .overlay(
                                Group {
                                    if cakeClicked {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .frame(width: 200, height: 200)
                                                .padding(10)
                                            Button(action: {
                                                cakeClicked = false
                                                cakeItem?.type.isDone = true
                                                updateCakeTask(isDone: true)
                                             
                                            }) {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.black)
                                            }
                                        }


                                    }
                                }
                             )
                   
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
                                 .frame(width: 50, height: 50)
                                 .foregroundColor(.blue)
                         }
                         .padding()
                     }
                 }
             }
        }.environmentObject(taskManager)

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

//#Preview {
//    Room()
//}
