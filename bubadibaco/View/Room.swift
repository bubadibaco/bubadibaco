//
//  Room.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 16/07/24.
//

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
    @State private var popupTodo = false
    
    
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
            ZStack {
                
                ScrollView(.horizontal) {
                    ZStack {
                        Image("bgRoom")
                        
                        ForEach(items, id: \.self) { item in
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: frameSizes[item.name]?.width, height: frameSizes[item.name]?.height)
                                .offset(x: itemOffsets[item.name]?.x ?? 0, y: itemOffsets[item.name]?.y ?? 0)
                                .onTapGesture {
                                    if item.name == "Bed" {
                                        checkTasksAndProceed()
                                    } else {
                                        objectClicked = item.name
                                        playSound(named: "\(item.name)Sound")
                                        isShowingAlphabets = true
                                    }
                                }
                            
                        }
                        
                    }
                    .navigationBarHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .background(
                        //                    NavigationLink(
                        //                        destination: Alphabets(objectName: objectClicked ?? ""),
                        //                        isActive: $isShowingAlphabets,
                        //                        label: { EmptyView() }
                        //                    )
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
                .background(
                    NavigationLink(
                        destination: Alphabets(objectName: objectClicked ?? "", isShowingAlphabets: $isShowingAlphabets),
                        isActive: $isShowingAlphabets,
                        label: { EmptyView()
                        }
                        
                    )
                    
                )
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if popupTodo {
                            Todo()
                        }
                        
                        Button(action: {
                            popupTodo.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                        })
                        
                    }
                }.padding(.bottom,30)            }
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
    
    func checkTasksAndProceed() {
            let eatTask = tasks.first { $0.name == "Eat" }
            let drinkTask = tasks.first { $0.name == "Drink" }
//            let playTask = tasks.first { $0.name == "Play" }

            if eatTask?.isDone == true && drinkTask?.isDone == true  {
                objectClicked = "Bed"
                playSound(named: "bedSound")
                isShowingAlphabets = true
                print("bisaa")
            } else {
                playSound(named: "WrongSound")
            }
        }
}


