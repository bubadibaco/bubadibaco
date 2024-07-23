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
    @State private var isShowingRecap = false
    @State private var animateScale = false
    var selectedAvatar: String
    
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
                                    .onAppear {
                                        self.animateScale = true
                                    }
                                    
                                
                            }
                            if selectedAvatar == "Terry" {
                                Image("dino")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(maxWidth: 800)
                            } else if selectedAvatar == "Trixie" {
                                Image("unicorn")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(maxWidth: 800)
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .background(
                        NavigationLink(
                            destination: Alphabets(isShowingAlphabets: $isShowingAlphabets, objectName: objectClicked ?? "", character: character),
                            isActive: $isShowingAlphabets,
                            label: { EmptyView() }
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
                            
                            Button(action: {
                                isShowingRecap = true
                            }, label: {
                                Text("Recap")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            })
                        }
                    }
                    .padding(.bottom, 30)
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
            else {
                audioPlayerHelper.playSound(named: "unlock_sound")
            }
        } 
        else {
            playSound(named: "unlock_sound")
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
