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
                    ZStack {
                        Image("board")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                        Text("\(objectName.uppercased())")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .bold()
                            .padding(.horizontal)
                    }
                    HStack {
                        PencilBoardView(isDone: $isDone, objectName: objectName)
                        Image("dino")
                    }
                    .padding(64)
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: isDone, perform: { newIsDone in
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
