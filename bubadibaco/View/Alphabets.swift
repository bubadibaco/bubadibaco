import SwiftUI

struct Alphabets: View {
    @State var objectName: String
    @State var isDone: Bool = false
    @Environment(\.presentationMode) var presentationMode

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
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
