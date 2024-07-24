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
    @State private var objectName: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isShowingAlphabets = false
    @State private var popupTodo = false
    @State private var isShowingRecap = false
    @State private var animateScale = false
    var selectedAvatar: String
    @State private var dragAmounts: [String: CGSize] = [:]
    @State private var draggingItem: String?

    
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
    
    @State private var itemOffsets: [String: CGPoint] = [
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
    let character: Character
    
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
                                    .scaleEffect(animateScale ? 1.2 : 1.0)
                                    .animation(
                                        Animation.easeInOut(duration: 1)
                                            .repeatForever(autoreverses: true)
                                    )
                                    .scaledToFit()
                                    .frame(width: frameSizes[item.name]?.width, height: frameSizes[item.name]?.height)
                                    .offset(
                                        x: (itemOffsets[item.name]?.x ?? 0) + (dragAmounts[item.name]?.width ?? 0),
                                        y: (itemOffsets[item.name]?.y ?? 0) + (dragAmounts[item.name]?.height ?? 0)
                                    )
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                draggingItem = item.name
                                                dragAmounts[item.name] = value.translation
                                            }
                                            .onEnded { value in
                                                var offsetX = (itemOffsets[item.name]?.x ?? 0) + value.translation.width
                                                var offsetY = (itemOffsets[item.name]?.y ?? 0) + value.translation.height
                                                itemOffsets[item.name] = CGPoint(x: offsetX, y: offsetY)
                                                dragAmounts[item.name] = .zero
                                                draggingItem = nil
                                            }
                                    )
                                    .onTapGesture {
                                        objectName = item.name
                                        if objectName == "Bed" || objectName == "Tent" {
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
                    }
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .background(
                        NavigationLink(
                            destination: Alphabets(objectName: objectName ?? ""),
                            isActive: $isShowingAlphabets,
                            label: { EmptyView() }
                        )
                    )
                    
                    VStack {
                        Spacer()
                        HStack(alignment: .bottom) {
                            if selectedAvatar == "Terry" {
                                Image("dino")
                                    .resizable()
                                    .scaledToFit()
                                //                                    .padding(.bottom, 10)
                                    .frame(maxWidth: 300)
                            } else if selectedAvatar == "Trixie" {
                                Image("unicorn")
                                    .resizable()
                                    .scaledToFit()
                                //                                    .padding(.bottom, 10)
                                    .frame(maxWidth: 300)
                            }
                            
                            Spacer()
                            HStack(alignment: .bottom) {
                                
                                if popupTodo {
                                    Todo()
                                }
                                
                                Button(action: {
                                    popupTodo.toggle()
                                }, label: {
                                    Image("listBtn")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.blue)
                                }).padding(.bottom, 25)
                                
                                Button(action: {
                                    isShowingRecap = true
                                }, label: {
                                    Text("Recap")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }).padding(.bottom, 25)
                            }
                        }.padding(.bottom, 0)
                        
                    }
                    .background(
                        NavigationLink(
                            destination: AvatarRecap(character: getCharacter(for: selectedAvatar), selectedAvatar: selectedAvatar),
                            isActive: $isShowingRecap,
                            label: { EmptyView() }
                        )
                    )
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func checkTasksAndProceed() {
        let eatTask = tasks.first { $0.name == "Eat" }
        let drinkTask = tasks.first { $0.name == "Drink" }
        let playTask = tasks.first { $0.name == "Play" }
        
        if eatTask?.isDone == true && drinkTask?.isDone == true && playTask?.isDone == true {
            if objectName == "Bed" {
                audioPlayerHelper.playSound(named: "clickObject_sound") {
                    audioPlayerHelper.playSound(named: "bed_sound")
                }
                isShowingAlphabets = true
            } else if objectName == "Tent" {
                audioPlayerHelper.playSound(named: "clickObject_sound") {
                    audioPlayerHelper.playSound(named: "tent_sound")
                }
                isShowingAlphabets = true
            }
            else {
                audioPlayerHelper.playSound(named: "unlock_sound")
            }
        }
        else {
            audioPlayerHelper.playSound(named: "unlock_sound")
            print("Tasks are not completed.")
        }
    }
    
    private func getCharacter(for avatarName: String) -> Character {
        if let character = characters.first(where: { $0.name == avatarName }) {
            return character
        } else {
            return characters[0]
        }
    }
}
