//
//  Task.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 15/07/24.
//

import Foundation

struct Task: Hashable {
    var name : String
    var isDone : Bool
}

let tasks = [
    Task(name: "Eat", isDone: false),
    Task(name: "Drink", isDone: false),
    Task(name: "Play", isDone: false),
    Task(name: "Sleep", isDone: false)
]
