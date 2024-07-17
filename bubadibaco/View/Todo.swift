//
//  Todo.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 17/07/24.
//

import SwiftUI

struct Todo: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        List {
                    ForEach(taskManager.tasks.indices, id: \.self) { index in
                        Text(taskManager.tasks[index].name)
                            .foregroundColor(taskManager.tasks[index].isDone ? .gray : .black)
                            .strikethrough(taskManager.tasks[index].isDone)
                    }
                }
                .frame(width: 200, height: 200)
     
    }
}

#Preview {
    Todo()
}
