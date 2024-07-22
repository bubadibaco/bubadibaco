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
    @State private var popupTodo = false
    
    
    let frameSizes: [String: CGSize] = [
        "Ball": CGSize(width: 150, height: 150),
        "Cake": CGSize(width: 200, height: 150),
        "Milk": CGSize(width: 250, height: 150),
        "Bed": CGSize(width: 400, height: 350),
        "Doll": CGSize(width: 0, height: 0),
        "Card": CGSize(width: 0, height: 0),
        "Beef": CGSize(width: 0, height: 0),
        "Corn": CGSize(width: 0, height: 0),
        "Soda": CGSize(width: 0, height: 0),
        "Tea": CGSize(width: 0, height: 0),
        "Sofa": CGSize(width: 0, height: 0),
        "Tent": CGSize(width: 450, height: 1000)


    ]
    
    let itemOffsets: [String: CGPoint] = [
        "Ball": CGPoint(x: 100, y: 300),
        "Cake": CGPoint(x: -700, y: 100),
        "Milk": CGPoint(x: 900, y: 10),
        "Bed": CGPoint(x: 400, y: 220),

        "Doll": CGPoint(x: 0, y: 0),
        "Card": CGPoint(x: 0, y: 0),
        "Beef": CGPoint(x: 0, y: 0),
        "Corn": CGPoint(x: 0, y: 0),
        "Soda": CGPoint(x: 0, y: 0),
        "Tea": CGPoint(x: 0, y: 0),
        "Sofa": CGPoint(x: 0, y: 0),
        "Tent": CGPoint(x: 2300, y: 200),

    ]
    
    private let audioPlayerHelper = AudioPlayerHelper()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ScrollView(.horizontal) {
                        ZStack {
                            Image("bgnew_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: geometry.size.height)
                                .clipped()
                            
                            ForEach(items, id: \.self) { item in
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: frameSizes[item.name]?.width, height: frameSizes[item.name]?.height)
                                    .offset(x: itemOffsets[item.name]?.x ?? 0, y: itemOffsets[item.name]?.y ?? 0)
                                    .onTapGesture {
                                        objectClicked = item.name

                                        if objectClicked == "Bed" || objectClicked == "Tent" {
                                            checkTasksAndProceed()
                                        } else {
                                            audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                audioPlayerHelper.playSound(named: "\(item.sound)")
                                            }
                                            isShowingAlphabets = true
                                        }
                                    }
                                
                            }
                            
                        }
                        //                    .navigationBarHidden(true)
                        //                    .navigationViewStyle(StackNavigationViewStyle())
                        //                    .background(
                        //                        //                    NavigationLink(
                        //                        //                        destination: Alphabets(objectName: objectClicked ?? ""),
                        //                        //                        isActive: $isShowingAlphabets,
                        //                        //                        label: { EmptyView() }
                        //                        //                    )
                        //                        NavigationLink(
                        //                            destination: Alphabets(objectName: objectClicked ?? "", isShowingAlphabets: $isShowingAlphabets),
                        //                            isActive: $isShowingAlphabets,
                        //                            label: { EmptyView() }
                        //                        )
                        //                    )
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
                                Todo().padding(.bottom,10)
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
                    }            }
            }.edgesIgnoringSafeArea(.all)
            
            
        }.navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func checkTasksAndProceed() {
        let eatTask = tasks.first { $0.name == "Eat" }
        let drinkTask = tasks.first { $0.name == "Drink" }
        let playTask = tasks.first { $0.name == "Play" }
        
        if eatTask?.isDone == true && drinkTask?.isDone == true && playTask?.isDone == true {

            if objectClicked == "Bed" {
                    audioPlayerHelper.playSound(named: "clickObject_sound") {
                        audioPlayerHelper.playSound(named: "bed_sound")
                    }
                    isShowingAlphabets = true
                } else if objectClicked == "Tent" {
                    audioPlayerHelper.playSound(named: "clickObject_sound") {
                        audioPlayerHelper.playSound(named: "tent_sound")
                    }
                    isShowingAlphabets = true
                }
            } else {
                audioPlayerHelper.playSound(named: "unlock_sound")
            }
    }
}

