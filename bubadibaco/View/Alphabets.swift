import SwiftUI

struct Alphabets: View {
    @State var showPencilBoard = false
    @State var currentLetter: String = ""
    @StateObject private var taskManager = TaskManager()
    @Binding var isShowingAlphabets: Bool
    
    let objectName: String
    let letters = (65...90).map { String(UnicodeScalar($0)!) }
    let character: Character
    
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
                        if let item = findItem(taskName: objectName) {
                            markTaskDone(taskName: item.type.name, item: item)
                            isShowingAlphabets = false
                        }
                        print(character.actions)
                        
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
    
    private func findItem(taskName: String) -> Item? {
        return items.first { $0.name.lowercased() == taskName.lowercased() }
    }
    
    private func markTaskDone(taskName: String, item: Item) {
        if let index = tasks.firstIndex(where: { $0.name == taskName }) {
            tasks[index].isDone = true
        }
        if let itemIndex = items.firstIndex(where: { $0.id == item.id }) {
            items[itemIndex].type.isDone = true
            character.actions[Task(name: taskName, isDone: true)] = items[itemIndex]
        }
        
        //        character.actions[Task(name: taskName, isDone: true)] = item
        //        printActions()
    }
    
    //    private func printActions() {
    //        for (task, item) in character.actions {
    //            print("Task: \(task.name), Item: \(item.name)")
    //        }
    //    }
    
}

//#Preview {
//    Alphabets(objectName: "ball")
//}
