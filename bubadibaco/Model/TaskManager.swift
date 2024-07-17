//
//  TaskManager.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 17/07/24.
//

import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = [
            Task(name: "Eat cake", isDone: false),
            Task(name: "Play ball", isDone: false),
            Task(name: "Go to bed", isDone: false)
        ]
        
        func updateTask(name: String, isDone: Bool) {
            if let index = tasks.firstIndex(where: { $0.name == name }) {
                tasks[index].isDone = isDone
            }
        }
    func isTaskDone(name: String) -> Bool {
            if let task = tasks.first(where: { $0.name == name }) {
                return task.isDone
            }
            return false
        }
}
