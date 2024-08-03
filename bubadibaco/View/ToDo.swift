//
//  Todo.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 17/07/24.
//

import SwiftUI

struct Todo: View {

    var body: some View {
        
        ZStack {
            let eatTask = tasks.first { $0.name == "Eat" }
            let drinkTask = tasks.first { $0.name == "Drink" }
            let playTask = tasks.first { $0.name == "Play" }
            
            if eatTask?.isDone == false || drinkTask?.isDone == false || playTask?.isDone == false {
                Image("boardShort_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: 280, height: 70)
                    .onAppear{
                        print("cilik")
                    }
                
                HStack(spacing: 30) {
                    ForEach(tasks.filter { $0.name != "Sleep" }) { task in
                        Image("\(task.name)\(task.isDone ? "Yellow" : "Green")")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 60)
                            .clipped()
                            .onAppear {
                                print(task.isDone ? "kuninggg" : "ijooo")
                            }
                    }
                }
            }
            else {
                Image("boardLong_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: 280, height: 70)
                    .onAppear{
                        print("gede")
                    }
                HStack(spacing: 30) {
                    ForEach(tasks) { task in
                        HStack {
                            if task.isDone {
                                Image("\(task.name)Yellow")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 145, height: 40)
                                    .clipped()
                                    .onAppear{
                                        print("kuning")
                                    }
                            }
                            else {
                                Image("\(task.name)Green")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 145, height: 40)
                                    .clipped()
                                    .onAppear{
                                        print("ijo")
                                    }
                            }
                        }
                        
                    }
                }
            }
        }
//        .onAppear{
//            print(tasks)
//        }
        //                .frame(height: 300)
        
        //        .frame(width: 100, height: 100)
    }
}

//#Preview {
//    Todo()
//}
