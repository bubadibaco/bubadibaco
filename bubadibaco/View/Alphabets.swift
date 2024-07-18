import SwiftUI

struct Alphabets: View {
    @State private var showPencilBoard = false
    @State private var currentLetter: String = ""
    let objectName: String
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
                        Text("\(objectName.capitalized)")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .bold()
                            .padding(.horizontal)
                    }
                                        
                    ScrollView {
                        VStack(spacing: 40) {
                            ForEach(0..<5, id: \.self) { row in
                                HStack(spacing: 20) {
                                    ForEach(0..<6, id: \.self) { column in
                                        if row * 6 + column < letters.count {
                                            Button(action: {
                                                currentLetter = letters[row * 6 + column]
                                                showPencilBoard = true
                                            }) {
                                                Text(letters[row * 6 + column])
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                    .frame(width: 80, height: 80)
                                                    .background(Color.pink)
                                                    .cornerRadius(10)
                                            }
                                            .sheet(isPresented: $showPencilBoard) {
                                                PencilBoardView(objectName: currentLetter)
                                            }
                                        } else {
                                            Spacer()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//#Preview {
//    Alphabets(objectName: "ball")
//}
