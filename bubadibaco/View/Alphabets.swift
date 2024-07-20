import SwiftUI

struct Alphabets: View {
    @State var showPencilBoard = false
    @State var currentLetter: String = ""
    let objectName: String
    let letters = (65...90).map { String(UnicodeScalar($0)!) }
    @StateObject private var taskManager = TaskManager()
    @Binding var isShowingAlphabets: Bool

    var body: some View {
        let bedItem = items.first { $0.name == "Bed" }
        let cakeItem = items.first { $0.name == "Cake" }
        let ballItem = items.first { $0.name == "Ball" }
        let milkItem = items.first { $0.name == "Milk" }

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
                   

                    Button(action: {
                        if objectName == "Bed" {
                            markTaskDone(taskName: "Sleep")
                            isShowingAlphabets = false
                            
                            print(bedItem?.type.name ?? "")
                        }
                        else if objectName == "Ball" {
                            markTaskDone(taskName: "Play")
                            isShowingAlphabets = false
                            let taskball = taskManager.tasks[1]

                            print(taskball.isDone)

                        }
                        else if objectName == "Milk" {
                            markTaskDone(taskName: "Drink")
                            isShowingAlphabets = false

                        }
                        else if objectName == "Cake" {
                            markTaskDone(taskName: "Eat")
                            isShowingAlphabets = false

                        }
                        
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
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
            .sheet(isPresented: $showPencilBoard) {
                PencilBoardView(showPencilBoard: $showPencilBoard, objectName: currentLetter)
                
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    private func markTaskDone(taskName: String) {
            if let index = tasks.firstIndex(where: { $0.name == taskName }) {
                tasks[index].isDone = true
            }
        }

}

//#Preview {
//    Alphabets(objectName: "ball")
//}
