import SwiftUI
import AVFAudio
import SpriteKit

class ParticleScene: SKScene {
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
                        Image(selectedAvatar)
                    }
                    .padding(64)
                    Spacer()
                    
                    if (isDone) {
                        Button("Back to Room") {
                            self.presentationMode.wrappedValue.dismiss()
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
                }
                
                if (isDone) {
                    GeometryReader { geo in
                        SpriteView(scene: ParticleScene(size: geo.size), options: [.allowsTransparency])
                    }
                }
            }
            .overlay(
                Button("Pronounce") {
                    let item = items.first { $0.name == objectName }
                    audioPlayerHelper.playSound(named: "\(item!.sound)")
                }
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 64, leading: 0, bottom: 0, trailing: 64)),
                alignment: .topTrailing
            )
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
