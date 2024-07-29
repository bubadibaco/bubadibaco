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
    @State private var isShowingAlphabets = false
    @State private var popupTodo = false
    @State private var isShowingRecap = false
    @State private var animateScale = false
    var selectedAvatar: String
    @State private var dragAmounts: [String: CGSize] = [:]
    @State private var draggingItem: String?
    @State private var selectedObjects: [String: String] = [:]
    @State private var stories: [Story] = [
        Story(name: "Terry or Trixie's House", isUnlocked: true),
        Story(name: "Second Story", isUnlocked: false),
        Story(name: "Third Story", isUnlocked: false)
    ]
    @State var justDone: Bool

    let frameSizes: [String: CGSize] = [
        "Ball": CGSize(width: 250, height: 250),
        "Cake": CGSize(width: 80, height: 80),
        "Milk": CGSize(width: 250, height: 150),
        "Bed": CGSize(width: 400, height: 350),
//        "Comb": CGSize(width: 150, height: 150),
//        "Pan": CGSize(width: 150, height: 280),
        "Soap": CGSize(width: 250, height: 150),
//        "Oven": CGSize(width: 600, height: 450),
        "Doll": CGSize(width: 0, height: 0),
        "Card": CGSize(width: 0, height: 0),
        "Beef": CGSize(width: 0, height: 0),
        "Corn": CGSize(width: 0, height: 0),
        "Soda": CGSize(width: 200, height: 100),
        "Tea": CGSize(width: 0, height: 0),
        "Sofa": CGSize(width: 0, height: 0),
        "Tent": CGSize(width: 450, height: 1000),
        "Flower": CGSize(width: 200, height: 200),
        "Books": CGSize(width: 100, height: 100),
        "Toothpaste": CGSize(width: 100, height: 100),
        "Toothbrush": CGSize(width: 100, height: 100),
        "Candle": CGSize(width: 100, height: 100),
        "Shampoo": CGSize(width: 100, height: 100),
        "LiquidSoap": CGSize(width: 100, height: 100),
        "Duck": CGSize(width: 100, height: 100),
        "Razor": CGSize(width: 100, height: 100),
        "Clock": CGSize(width: 100, height: 100),
        "Cat": CGSize(width: 300, height: 300),
        "Plant": CGSize(width: 200, height: 200),
        "Jar": CGSize(width: 200, height: 200),
        "Cup": CGSize(width: 75, height: 75),
        "Jug": CGSize(width: 100, height: 100),
        "Eggs": CGSize(width: 100, height: 100),
        "Bag": CGSize(width: 200, height: 200),
        "Radio": CGSize(width: 150, height: 150),
        "Ramen": CGSize(width: 150, height: 150),
        "Novel": CGSize(width: 100, height: 100),
        "Telescope": CGSize(width: 200, height: 300),
        "Brush": CGSize(width: 200, height: 200),
    ]
    
    @State private var itemOffsets: [String: CGPoint] = [
        "Ball": CGPoint(x: 100, y: 300),
        "Cake": CGPoint(x: -1010, y: 135),
        "Milk": CGPoint(x: 900, y: 10),
        "Bed": CGPoint(x: 400, y: 220),
//        "Comb": CGPoint(x: -1800, y: 5),
//        "Pan": CGPoint(x: -750, y: -30),
//        "Oven": CGPoint(x: -550, y: -30),
        "Soap": CGPoint(x: -1800, y: -30),
        "Books": CGPoint(x: 750, y: -330),
        "Doll": CGPoint(x: 0, y: 0),
        "Card": CGPoint(x: 0, y: 0),
        "Beef": CGPoint(x: 0, y: 0),
        "Corn": CGPoint(x: 0, y: 0),
        "Soda": CGPoint(x: -750, y: 125),
        "Tea": CGPoint(x: -850, y: 122),
        "Sofa": CGPoint(x: 0, y: 0),
        "Tent": CGPoint(x: 2200, y: 200),
        "Flower": CGPoint(x: -300, y: 150),
        "Toothpaste": CGPoint(x: -2050, y: -100),
        "Shampoo": CGPoint(x: -1500, y: 0),
        "LiquidSoap": CGPoint(x: -1900, y: -90),
        "Soap": CGPoint(x: -1200, y: 0),
        "Toothbrush": CGPoint(x: -2150, y: -15),
        "Candle": CGPoint(x: 800, y: 25),
        "Brush": CGPoint(x: -2100, y: 150),
        "Duck": CGPoint(x: -2200, y: 400),
        "Razor": CGPoint(x: -2250, y: -15),
        "Clock": CGPoint(x: 700, y: 30),
        "Cat": CGPoint(x: 500, y: 400),
        "Plant": CGPoint(x: 1200, y: 200),
        "Jar": CGPoint(x: 1000, y: 400),
        "Jug": CGPoint(x: -900, y: -40),
        "Bag": CGPoint(x: 1000, y: 200),
        "Eggs": CGPoint(x: -400, y: -50),
        "Radio": CGPoint(x: 800, y: -210),
        "Ramen": CGPoint(x: -1100, y: 130),
        "Novel": CGPoint(x: 800, y: -70),
        "Cup": CGPoint(x: -1000, y: 150),
        "Telescope": CGPoint(x: 2500, y: 400),
    ]
    
    private let audioPlayerHelper = AudioPlayerHelper()
    let primaryColor = Color("PrimaryColor")
    let character: Character
    @State private var isSleepTaskDone = false
    
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
                                    .scaleEffect(animateScale ? 1.1 : 1.0)
                                    .animation(
                                        Animation.easeInOut(duration: 1)
                                            .repeatForever(autoreverses: true),
                                        value: animateScale
                                    )
                                    .onAppear {
//                                        print("the printed \(items.first(where: { $0.name == "Cake" })?.isDone)")
                                        animateScale = true
                                    }
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
                                        if popupTodo {
                                            popupTodo.toggle()
                                        }
                                        objectName = item.name
                                        if objectName == "Bed" || objectName == "Tent" {
                                            checkTasksAndProceedSleep()
                                        } else {
                                            audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                audioPlayerHelper.playSound(named: "\(item.sound)")
                                            }
                                            isShowingAlphabets = true
                                        }
                                        updateSelectedObjects(for: objectName!)
                                    }
                                    .zIndex(draggingItem == item.name ? 1 : 0)
                            }
                            
                            ForEach(randomObjects, id: \.self) { item in
                                Image(item.image)
                                    .resizable()
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
                                        if popupTodo {
                                            popupTodo.toggle()
                                        }
                                        objectName = item.name
                                        if objectName == "Bed" || objectName == "Tent" {
                                            checkTasksAndProceedSleep()
                                        } else {
                                            audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                audioPlayerHelper.playSound(named: "\(item.sound)")
                                            }
                                            isShowingAlphabets = true
                                        }
                                    }
                                    .zIndex(draggingItem == item.name ? 1 : 0)
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .background(
                        NavigationLink(                     
                            destination: Alphabets(objectName: objectName ?? "", selectedAvatar: getCharacter(for: selectedAvatar).image),
                            isActive: $isShowingAlphabets,
                            label: { EmptyView() }
                        )
                    )
                    
                    VStack {
                        Spacer()
                        HStack(alignment: .bottom) {
                            HStack(alignment: .bottom) {
                                if selectedAvatar == "Terry" {
                                    Image("dino")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 300)
                                        .onTapGesture {
                                            popupTodo.toggle()
                                            playAvatarSound(for: selectedAvatar)
                                        }
                                        .onAppear {
                                            audioPlayerHelper.playSound(named: "rawr_boy_sound")
                                        }
                                } else if selectedAvatar == "Trixie" {
                                    Image("unicorn")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 300)
                                        .onTapGesture {
                                            popupTodo.toggle()
                                            playAvatarSound(for: selectedAvatar)
                                        }
                                        .onAppear {
                                            audioPlayerHelper.playSound(named: "yeehaw_girl_sound")
                                        }
                                }
                                if popupTodo {
                                    Todo().padding(.bottom, 150)
                                        .offset(x: -48)
                                } else {
                                    Image("tapme_image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 90)
                                        .clipped()
                                        .padding(.bottom, 155)
                                        .offset(x: -95)
                                        .onTapGesture {
                                            popupTodo.toggle()
                                            playAvatarSound(for: selectedAvatar)
                                        }
                                }
                            }
                            
                            // Show the button only if sleep task is done
                            if isSleepTaskDone {
                                Button(action: {
                                    isShowingRecap = true
                                }, label: {
                                    Text("End the Day")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(.vertical, 20)
                                        .padding(.horizontal, 100)
                                        .background(
                                            Capsule(style: .circular)
                                                .fill(primaryColor)
                                        )
                                })
                                .padding(.bottom, 25)
                            }
                        }
                        .padding(.bottom, 0)
                    }
                    .background(
                        NavigationLink(
                            destination: AvatarRecap(character: getCharacter(for: selectedAvatar), selectedAvatar: selectedAvatar, selectedObjects: selectedObjects, stories: $stories),
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
    
    private func checkTasksAndProceedSleep() {
        if let taskIndex = tasks.firstIndex(where: { $0.name == "Sleep" }) {
            tasks[taskIndex].isDone = true
            isSleepTaskDone = true
            audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
        }
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
            } else {
                audioPlayerHelper.playSound(named: "unlock_sound")
            }
        } else {
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
    
    private func updateSelectedObjects(for objectName: String) {
        if ["Cake", "Beef"].contains(objectName) {
            selectedObjects["Eat"] = objectName
        } else if ["Milk", "Soda"].contains(objectName) {
            selectedObjects["Drink"] = objectName
        } else if ["Ball"].contains(objectName) {
            selectedObjects["Play"] = objectName
        } else if ["Bed", "Tent"].contains(objectName) {
            selectedObjects["Sleep"] = objectName
        }
    }
    
    private func playAvatarSound(for avatarName: String) {
        if avatarName == "Terry" {
            if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imhungry_boy_sound")
            } else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imthirsty_boy_sound")
            } else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imbored_boy_sound")
            } else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
            }
        } else if avatarName == "Trixie" {
            if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imhungry_girl_sound")
            } else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imthirsty_girl_sound")
            } else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imbored_girl_sound")
            } else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                audioPlayerHelper.playSound(named: "imsleepy_girl_sound")
            }
        }
    }
}
