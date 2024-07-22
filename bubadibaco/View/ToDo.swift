//
//  Todo.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 17/07/24.
//

import SwiftUI

struct Todo: View {
    var body: some View {
        List {
            ForEach(tasks) { task in
                HStack {
                    if task.isDone {
                        Text(task.name).strikethrough()
                    }
                    else {
                        Text(task.name)
                    }
                }
                .padding()
            }
        }
        .frame(width: 200, height: 200)
    }
}

