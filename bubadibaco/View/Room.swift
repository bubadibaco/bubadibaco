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
        "Soda": CGSize(width: 100, height: 100),
        "Tea": CGSize(width: 110, height: 110),
        "Sofa": CGSize(width: 0, height: 0),
        "Tent": CGSize(width: 450, height: 1000),
        "Flower": CGSize(width: 200, height: 200),
        "Bag": CGSize(width: 200, height: 200),
        "Books": CGSize(width: 100, height: 100),
        "Book": CGSize(width: 100, height: 100),
        "Radio": CGSize(width: 200, height: 200),
        "Kettle": CGSize(width: 100, height: 100),
        "Jar": CGSize(width: 100, height: 100),
        "Egg": CGSize(width: 120, height: 120),
        
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
        "Doll": CGPoint(x: 0, y: 0),
        "Card": CGPoint(x: 0, y: 0),
        "Beef": CGPoint(x: 0, y: 0),
        "Corn": CGPoint(x: 0, y: 0),
        "Soda": CGPoint(x: -750, y: 125),
        "Tea": CGPoint(x: -850, y: 122),
        "Sofa": CGPoint(x: 0, y: 0),
        "Tent": CGPoint(x: 2300, y: 200),
        "Flower": CGPoint(x: -640, y: -100),
        "Bag": CGPoint(x: 1000, y: 180),
        "Books": CGPoint(x: 790, y: -90),
        "Book": CGPoint(x: 830, y: -200),
        "Egg": CGPoint(x: -1150, y: -270),
        "Kettle": CGPoint(x: -720, y: -50),
        "Jar": CGPoint(x: -1400, y: -70),
        "Radio": CGPoint(x: 780, y: 10)
        
    ]
    
    private let audioPlayerHelper = AudioPlayerHelper()
    let primaryColor = Color("PrimaryColor")
    let character: Character
    @State private var isLampOn: Bool = false
    
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

                            if isLampOn {
                                HalfCircle()
                                    .fill(Color.yellow.opacity(0.3))
                                    .frame(width: 180, height: 300)
                                    .cornerRadius(200)
                                    .offset(x: 410, y: -230)
                                    .zIndex(0)
                                    .onAppear{
                                        print("on")
                                    }
                            }
                            
                            Image("lamp_image")
                                .resizable()
                                .frame(width: 159, height: 100)
                                .offset(x: 410, y: -270)
                                .onTapGesture {
                                    isLampOn.toggle()
                                }
                                .zIndex(1)
                            
                            
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
                                                if item.name != "Bed" {
                                                    draggingItem = item.name
                                                    dragAmounts[item.name] = value.translation
                                                }
                                            }
                                            .onEnded { value in
                                                if item.name != "Bed" {
                                                    var offsetX = (itemOffsets[item.name]?.x ?? 0) + value.translation.width
                                                    var offsetY = (itemOffsets[item.name]?.y ?? 0) + value.translation.height
                                                    itemOffsets[item.name] = CGPoint(x: offsetX, y: offsetY)
                                                    dragAmounts[item.name] = .zero
                                                    draggingItem = nil
                                                }
                                            }
                                    )
                                    .onTapGesture {
                                        if popupTodo {
                                            popupTodo.toggle()
                                            
                                        }
                                        objectName = item.name
                                        if objectName == "Bed" || objectName == "Tent" {
                                            checkTasksAndProceed()
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
                                            checkTasksAndProceed()
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
                            destination: Alphabets(objectName: objectName ?? "", selectedAvatar: getCharacter(for: selectedAvatar).image, justDone: justDone),
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
                                            if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imhungry_boy_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imthirsty_boy_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imbored_boy_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
                                                
                                            }
                                        }
                                    
                                } else if selectedAvatar == "Trixie" {
                                    Image("unicorn")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 300)
                                        .onTapGesture {
                                            popupTodo.toggle()
                                            
                                            if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imhungry_girl_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imthirsty_girl_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imbored_girl_sound")
                                                
                                            }
                                            else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                                                audioPlayerHelper.playSound(named: "imsleepy_girl_sound")
                                                
                                            }
                                            
                                            
                                        }
                                    
                                }
                                if popupTodo {
                                    Todo().padding(.bottom, 150)
                                        .offset(x:-48)
                                }
                                else {
                                    Image("tapme_image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 90)
                                        .clipped()
                                        .padding(.bottom, 155)
                                        .offset(x:-95)
                                        .onTapGesture{
                                            popupTodo.toggle()
                                            
                                            if selectedAvatar == "Terry" {
                                                if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imhungry_boy_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imthirsty_boy_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imbored_boy_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
                                                    
                                                }
                                            }
                                            else if selectedAvatar == "Trixie" {
                                                if tasks.first(where: { $0.name == "Eat" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imhungry_girl_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Drink" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imthirsty_girl_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Play" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imbored_girl_sound")
                                                    
                                                }
                                                else if tasks.first(where: { $0.name == "Sleep" })?.isDone == false {
                                                    audioPlayerHelper.playSound(named: "imsleepy_girl_sound")
                                                    
                                                }
                                            }
                                            
                                        }
                                }
                            }
                            
                            Spacer()
                            //                            HStack(alignment: .bottom) {
                            //                                if popupTodo {
                            //                                    Todo()
                            //                                }
                            //
                            //                                Button(action: {
                            //                                    popupTodo.toggle()
                            //                                }, label: {
                            //                                    Image("listBtn")
                            //                                        .resizable()
                            //                                        .frame(width: 100, height: 100)
                            //                                        .foregroundColor(.blue)
                            //                                }).padding(.bottom, 25)
                            //
                            Button(action: {
                                isShowingRecap = true
                            }, label: {
                                Text("Recap")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }).padding(.bottom, 25)
                            //                            }
                        }.padding(.bottom, 0)
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
}

struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}



