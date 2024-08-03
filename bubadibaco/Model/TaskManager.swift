//
//  TaskManager.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 18/07/24.
//

//
//  TaskManager.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 17/07/24.
//

import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = [
        Task(name: "Eat", isDone: false),
        Task(name: "Play", isDone: false),
        Task(name: "Drink", isDone: false),
        Task(name: "Sleep", isDone: false)]
    
func updateTask(name: String, isDone: Bool) {
        if let index = tasks.firstIndex(where: { $0.name == name }) {
         tasks[index].isDone = isDone }}
    
    func areTasksDone(names: [String]) -> Bool {
        for name in names {
            guard let task = tasks.first(where: { $0.name == name })
            else {
                return false
            }
            if !task.isDone {
                return false
            }
        }
        return true
    }
}
