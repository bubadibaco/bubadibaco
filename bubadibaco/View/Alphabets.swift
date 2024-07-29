import SwiftUI
import AVFAudio
import SpriteKit

final class ParticleScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .clear
        
        if let emitter1 = SKEmitterNode(fileNamed: "MyParticle") {
            emitter1.position.y = size.height
            emitter1.particleColorSequence = nil
            emitter1.particleColorBlendFactor = 1
            emitter1.particleColorBlueRange = 1
            emitter1.particleColorGreenRange = 1
            emitter1.particleColorRedRange = 1
            emitter1.position.x = (size.width / 4)
            addChild(emitter1)
        }
        
        if let emitter2 = SKEmitterNode(fileNamed: "MyParticle") {
            emitter2.position.y = size.height
            emitter2.particleColorSequence = nil
            emitter2.particleColorBlendFactor = 1
            emitter2.particleColorBlueRange = 1
            emitter2.particleColorGreenRange = 1
            emitter2.particleColorRedRange = 1
            emitter2.position.x = size.width - (size.width / 4)
            addChild(emitter2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Alphabets: View {
    @State var objectName: String
    @State var selectedAvatar: String
    @State var isDone: Bool = false
    @Environment(\.presentationMode) var presentationMode
    private let audioPlayerHelper = AudioPlayerHelper()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
                
                VStack {
                    HStack {
                        PencilBoardView(isDone: $isDone, objectName: objectName)
                    }
                    .padding(64)
                    Spacer()
                }
                
                if (isDone) {
                    GeometryReader { geo in
                        SpriteView(scene: ParticleScene(size: geo.size), options: [.allowsTransparency])
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay(
            ZStack {
                if (isDone) {
                    Button("Back to Room") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .onAppear {
                        audioPlayerHelper.playSound(named: "yay_sound")
                        if selectedAvatar == "unicorn"{
                            if let item = items.first(where: { $0.name == objectName }) {
                                if item.type?.name == "Eat" {
                                    audioPlayerHelper.playSound(named: "slurp_sound") {
                                        audioPlayerHelper.playSound(named: "imsofull_girl_sound")
                                    }
                                }
                                else if item.type?.name == "Drink" {
                                    audioPlayerHelper.playSound(named: "afterdrink_sound") {
                                        audioPlayerHelper.playSound(named: "imhydrated_girl_sound")
                                    }
                                }
                                else if item.type?.name == "Play" {
                                    audioPlayerHelper.playSound(named: "funplay_sound") {
                                        audioPlayerHelper.playSound(named: "thisissofun_girl_sound")
                                    }
                                }
                                else if item.type?.name == "Sleep" {
                                    audioPlayerHelper.playSound(named: "yawn_sound") {
                                        audioPlayerHelper.playSound(named: "imsleepy_girl_sound")
                                    }
                                }
                            }
                        }
                        else if selectedAvatar == "dino" {
                            if let item = items.first(where: { $0.name == objectName }) {
                                if item.type?.name == "Eat" {
                                    audioPlayerHelper.playSound(named: "slurp_sound") {
                                        audioPlayerHelper.playSound(named: "imsofull_boy_sound")
                                    }
                                }
                                else if item.type?.name == "Drink" {
                                    audioPlayerHelper.playSound(named: "afterdrink_sound") {
                                        audioPlayerHelper.playSound(named: "imhydrated_boy_sound")
                                    }
                                }
                                else if item.type?.name == "Play" {
                                    audioPlayerHelper.playSound(named: "funplay_sound") {
                                        audioPlayerHelper.playSound(named: "thisissofun_boy_sound")
                                    }
                                }
                                else if item.type?.name == "Sleep" {
                                    audioPlayerHelper.playSound(named: "yawn_sound") {
                                        audioPlayerHelper.playSound(named: "imsleepy_boy_sound")
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 20)
                    .padding(.horizontal, 100)
                    .background(
                        Capsule(style: .circular)
                            .fill()
                            .foregroundColor(.green)
                    )
                }
            },
            alignment: .bottom
        )
    }
}
