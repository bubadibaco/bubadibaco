import SwiftUI

struct Alphabets: View {
    @State var showPencilBoard = false
    @State var objectName: String
    @State var isDone: Bool = false
    @StateObject private var taskManager = TaskManager()
    @Environment(\.dismiss) var dismiss
    
    let letters = (65...90).map { String(UnicodeScalar($0)!) }

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
                        PencilBoardView(objectName: objectName)
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
    }
}
