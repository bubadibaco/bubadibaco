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
            ScrollView {
                ZStack {
                    Image("bgTodo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 600)
                        .clipped()
                    
                    VStack(spacing: 10) {
                            ForEach(tasks) {task in
                                
                                HStack {
                                    if task.isDone {
                                        Image("\(task.name)Yellow")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 160, height: 50)
                                            .clipped()
                                    }
                                    else {
                                        Image("\(task.name)Green")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 160, height: 50)
                                            .clipped()

                                    }
                                }
                                
                                
                            }
                            
//                            
//                            Image("EatYellow")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 160, height: 50)
//                                .clipped()
                        
                    }
                    .padding(.top, 10)
                }.frame(height: 300)
            }
        }
        .frame(width: 200, height: 200)
        //        .frame(width: 200, height: 200)
        
        //        List {
        //            ForEach(tasks) { task in
        //
        //
        //                HStack {
        //                    if task.isDone {
        //
        //
        //                        Text(task.name).strikethrough()
        //                    }
        //                    else {
        //                        Text(task.name)
        //                    }
        //                }
        //                .padding()
        //
        //
        //
        //
        //            }
        //        }
        //        .frame(width: 200, height: 200)
    }
}

//#Preview {
//    Todo()
//}
