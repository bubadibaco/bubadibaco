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
    @State private var highestZIndex: Double = 0
    @State private var toDoGuide = false
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
    @State private var zOrder: [String] = []
    
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
        //        "Tea": CGSize(width: 0, height: 0),
        "Sofa": CGSize(width: 0, height: 0),
        "Tent": CGSize(width: 450, height: 1000),
        "Flower": CGSize(width: 200, height: 200),
        "Books": CGSize(width: 100, height: 100),
        "Toothpaste": CGSize(width: 100, height: 100),
        "Toothbrush": CGSize(width: 100, height: 100),
        "Candle": CGSize(width: 100, height: 100),
        "Shampoo": CGSize(width: 100, height: 100),
        "Conditioner": CGSize(width: 100, height: 100),
        "Duck": CGSize(width: 100, height: 100),
        "Razor": CGSize(width: 100, height: 100),
        "Clock": CGSize(width: 100, height: 100),
        "Cat": CGSize(width: 300, height: 300),
        "Plant": CGSize(width: 200, height: 200),
        "Jar": CGSize(width: 200, height: 200),
        "Tea": CGSize(width: 75, height: 75),
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
        //        "Soap": CGPoint(x: -1800, y: -30),
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
        "Shampoo": CGPoint(x: -1930, y: -102),
        "Conditioner": CGPoint(x: -1900, y: -90),
        "Soap": CGPoint(x: -1980, y: -100),
        "Toothbrush": CGPoint(x: -1800, y: 0),
        "Candle": CGPoint(x: 800, y: 25),
        "Brush": CGPoint(x: -2100, y: 150),
        "Duck": CGPoint(x: -2200, y: 400),
        "Razor": CGPoint(x: -2250, y: -15),
        "Clock": CGPoint(x: 700, y: 30),
        "Cat": CGPoint(x: 500, y: 400),
        "Plant": CGPoint(x: 1200, y: 200),
        "Jar": CGPoint(x: 1000, y: 400),
        "Jug": CGPoint(x: -700, y: -40),
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
    @State private var isLampOn: Bool = false
    @State private var isSleepTaskDone = false
    @State private var showerOn: Bool = false
    @State private var stoveOn: Bool = false
    
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
                                .zIndex(-2)
                            
                            
                            if isLampOn {
                                HalfCircle()
                                    .fill(Color.yellow.opacity(0.3))
                                    .frame(width: 180, height: 300)
                                    .cornerRadius(200)
                                    .offset(x: 410, y: -230)
                                    .onAppear{
                                        print("on")
                                    }
                                
                            }
                            
                            ZStack {
                                if showerOn {
                                    WaterDropsView(showerOn: $showerOn)
                                }
                                Image("shower_image")
                                    .resizable()
                                    .frame(width: 115, height: 43)
                                    .offset(x: -2350, y: -160)
                                    .onTapGesture {
                                        showerOn.toggle()
                                        audioPlayerHelper.playSound(named: "shower_sound"){
                                            audioPlayerHelper.playSound(named: "water_sound")

                                        }
                                    }
                                
                                if stoveOn {
                                    FireAnimationView()
                                        .frame(width: 50, height: 50)
                                        .offset(x: -980, y: -50)
                                }
                                
                                Image("stove_image")
                                    .resizable()
                                    .frame(width: 200, height: 100)
                                    .offset(x: -950, y: 10)
                                    .onTapGesture {
                                        stoveOn.toggle()
                                        print("Stove is now \(stoveOn ? "On" : "Off")")
                                    }
                            }
                            
                            Image("lamp_image")
                                .resizable()
                                .frame(width: 159, height: 100)
                                .offset(x: 410, y: -270)
                                .onTapGesture {
                                    isLampOn.toggle()
                                    audioPlayerHelper.playSound(named: "switch_sound"){
                                        audioPlayerHelper.playSound(named: "lamp_sound")
                                    }
                                    
                                }
                            
                            
                            ForEach(items, id: \.self) { item in
                                Image(item.image)
                                    .resizable()
                                //                                    .scaleEffect(draggingItem == item.name ? 1.2 : (animateScale ? 1.1 : 1.0))
                                //                                                                        .animation(
                                //                                                                            draggingItem == item.name ? .spring() :
                                //                                                                            Animation.easeInOut(duration: 1).repeatForever(autoreverses: true),
                                //                                                                            value: draggingItem == item.name ? draggingItem == item.name : animateScale
                                //                                                                        )
                                //                                    .scaleEffect(draggingItem == item.name ? 1.2 : 1.0)
                                //                                    .animation(.spring(), value: draggingItem == item.name)
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
                                                    audioPlayerHelper.playSound(named: "drag_sound")
                                                    dragAmounts[item.name] = value.translation
                                                    updateZOrder(for: item.name)
                                                    if item.name == "Duck" {
                                                        audioPlayerHelper.playSound(named: "quack_sound")
                                                    }
                                                    
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
                                        toDoGuide = false
                                        objectName = item.name
                                        if objectName == "Bed" || objectName == "Tent" {
                                            checkTasksAndProceed()
                                            toDoGuide = true

                                            //                                                isSleepTaskDone = true
                                        } else {
                                            audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                audioPlayerHelper.playSound(named: "\(item.sound)")
                                            }
                                            isShowingAlphabets = true
                                        }
                                        
                                        updateSelectedObjects(for: objectName!)
                                        
                                    }
                                    .zIndex(zIndex(for: item.name))
                            }
                            
                            ForEach(randomObjects, id: \.self) { item in
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(draggingItem == item.name ? 1.1 : 1.0)
                                    .animation(.spring(), value: draggingItem == item.name)
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
                                                audioPlayerHelper.playSound(named: "drag_sound")
                                                if item.name == "Cat" {
                                                    print("lallacat")
                                                    audioPlayerHelper.playSound(named: "meow_sound")
                                                }
                                                else if item.name == "Duck" {
                                                    audioPlayerHelper.playSound(named: "quack_sound"){
                                                        audioPlayerHelper.playSound(named: "drag_sound")
                                                    }
                                                }
                                                updateZOrder(for: item.name)
                                                
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
                                        toDoGuide = false
                                        if item.name != "Toothbrush" && item.name != "Toothpaste" && item.name != "Conditioner" && item.name != "Telescope" && item.name != "Stove"{

                                            objectName = item.name
                                            if objectName == "Bed" || objectName == "Tent" {
                                                checkTasksAndProceedSleep()
                                                toDoGuide = true

                                            } else {
                                                toDoGuide = true

                                                audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                    audioPlayerHelper.playSound(named: "\(item.sound)")
                                                    
                                                }
                                                isShowingAlphabets = true
                                            }
                                        }
                                        else {
                                            toDoGuide = true

                                            audioPlayerHelper.playSound(named: "clickObject_sound") {
                                                audioPlayerHelper.playSound(named: "\(item.sound)")
                                            }
                                        }
                                    }
                                    .zIndex(zIndex(for: item.name))
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
                    .overlay(
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
                                                playAvatarSound(for: selectedAvatar)
                                            }
                                            .zIndex(0)
                                        
                                    } else if selectedAvatar == "Trixie" {
                                        Image("unicorn")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 300)
                                            .onTapGesture {
                                                playAvatarSound(for: selectedAvatar)
                                            }
                                            .zIndex(0)
                                        
                                    }
                                    
                                    Image("tapme_image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 90)
                                        .clipped()
                                        .padding(.bottom, 155)
                                        .offset(x: -95)
                                        .onTapGesture {
                                            playAvatarSound(for: selectedAvatar)
                                        }
                                    
                                }.onAppear {
                                    toDoGuide = true
                                }
                                
                                Spacer()
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
                        
                        
                    )
                    
                    if toDoGuide {
                        VStack {
                            HStack {
                                Spacer()
                                Todo()
                                    .onAppear {
                                        print(toDoGuide)
                                    }
                                Spacer()
                            }
                            Spacer()
                        }.onAppear{
                            print(tasks)
                        }
                    }
                    VStack {
                        HStack {
                            NavigationLink(destination: GameViewControllerWrapper()) {
                            VStack {
                                Text(Image(systemName: "arrow.left"))

                                .foregroundColor(.white)
                                .font(Font.custom("Cutiemollydemo", size: 30))
                                .bold()
                                .padding(.vertical, 20)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule(style: .circular)
                                        .fill(primaryColor)
                                )
                            }.padding().padding(.leading,20)
                        }
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    
                    
                }.background(
                    NavigationLink(
                        destination: AvatarRecap(character: getCharacter(for: selectedAvatar), selectedAvatar: selectedAvatar, selectedObjects: selectedObjects, stories: $stories),
                        isActive: $isShowingRecap,
                        label: { EmptyView() }
                    )
                )
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
                toDoGuide = false
                toDoGuide = true

                if let taskIndex = tasks.firstIndex(where: { $0.name == "Sleep" }) {
                    tasks[taskIndex].isDone = true
                    isSleepTaskDone = true
//                    audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
                }
            } else if objectName == "Tent" {
                audioPlayerHelper.playSound(named: "clickObject_sound") {
                    audioPlayerHelper.playSound(named: "tent_sound")
                }
                isShowingAlphabets = true
                toDoGuide = false
                toDoGuide = true

                if let taskIndex = tasks.firstIndex(where: { $0.name == "Sleep" }) {
                    tasks[taskIndex].isDone = true
                    isSleepTaskDone = true
//                    audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
                }
            } else {
                toDoGuide = false
                if selectedAvatar == "Terry" {
                    audioPlayerHelper.playSound(named: "unlockbed_boy_sound")
                }
                else if selectedAvatar == "Trixie" {
                    audioPlayerHelper.playSound(named: "unlockbed_girl_sound")

                }
                toDoGuide = true

            }
        } else {
            toDoGuide = false
            if selectedAvatar == "Terry" {
                audioPlayerHelper.playSound(named: "unlockbed_boy_sound")
            }
            else if selectedAvatar == "Trixie" {
                audioPlayerHelper.playSound(named: "unlockbed_girl_sound")

            }
            print("Tasks are not completed.")
            toDoGuide = true

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
        if ["Cake", "Beef", "Ramen"].contains(objectName) {
            selectedObjects["Eat"] = objectName
        } else if ["Milk", "Soda", "Tea"].contains(objectName) {
            selectedObjects["Drink"] = objectName
        } else if ["Ball", "Duck"].contains(objectName) {
            selectedObjects["Play"] = objectName
        } else if ["Bed", "Tent"].contains(objectName) {
            selectedObjects["Sleep"] = objectName
        }
    }
    
    private func zIndex(for itemName: String) -> Double {
        guard let index = zOrder.firstIndex(of: itemName) else { return 0 }
        return Double(index) + 1
    }
    
    private func updateZOrder(for itemName: String) {
        zOrder.removeAll { $0 == itemName }
        zOrder.append(itemName)
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
