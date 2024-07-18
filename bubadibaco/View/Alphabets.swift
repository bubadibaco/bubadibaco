import SwiftUI

struct Alphabets: View {
    @State private var showPencilBoard = false
    var objectName: String
    let letters = (65...90).map { String(UnicodeScalar($0)!) }
    @StateObject private var taskManager = TaskManager()
    @Binding var isShowingAlphabets: Bool

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
                    
                    Button(action: {
                        if objectName == "bed" {
                            updateBedTask(isDone: true)
                            isShowingAlphabets = false

                        }
                        else if objectName == "ball" {
                            updateBallTask(isDone: true)
                            isShowingAlphabets = false
                            let taskball = taskManager.tasks[1]

                            print(taskball.isDone)

                        }
                        else if objectName == "milk" {
                            updateMilkTask(isDone: true)
                            isShowingAlphabets = false

                        }
                        else if objectName == "cake" {
                            updateCakeTask(isDone: true)
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
                                                print("\(letters[row * 6 + column])")
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
                                                PencilBoardView(objectName: "\(letters[row * 6 + column])")
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
    func updateBallTask(isDone: Bool) {
        taskManager.updateTask(name: "Play ball", isDone: isDone)
        
    }
    
    func updateCakeTask(isDone: Bool) {
        taskManager.updateTask(name: "Eat cake", isDone: isDone)
    }
    
    func updateBedTask(isDone: Bool) {
        taskManager.updateTask(name: "Go to bed", isDone: isDone)
    }
    func updateMilkTask(isDone: Bool) {
        taskManager.updateTask(name: "Drink milk", isDone: isDone)
    }
}

//#Preview {
//    Alphabets(objectName: "ball")
//}
