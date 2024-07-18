//
//  Task.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 15/07/24.
//

import Foundation

struct Task: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var isDone: Bool
}
