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
            ZStack {
                ZStack {
                    Image("bubbleTodo_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 380)
                        .clipped()
                    
                    VStack(spacing:0) {
                            ForEach(tasks) {task in
                                HStack {
                                    if task.isDone {
                                        Image("\(task.name)Yellow")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 40)
                                            .clipped()
                                    }
                                    else {
                                        Image("\(task.name)Green")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 40)
                                            .clipped()

                                    }
                                }
                            }
                    }
                    .padding(.top, 10)
                    .padding(.trailing,-12)
                }.frame(height: 300)
            }
        }
        .frame(width: 250, height: 200)
    }
}

//#Preview {
//    Todo()
//}
