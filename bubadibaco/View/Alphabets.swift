import SwiftUI
import AVFAudio

struct Alphabets: View {
    @State var objectName: String
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
                        Image("dino")
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
