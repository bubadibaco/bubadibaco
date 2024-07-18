//
//  Character.swift
//  bubadibaco
//
//  Created by Michael Eko on 16/07/24.
//

import Foundation

class Character: ObservableObject, Hashable {
    var name: String
    var image: String
    @Published var actions: [Task: Item] = [:]
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(image)
    }
}

let characters = [
    Character(name: "Terry", image: "dino"),
    Character(name: "Trixie", image: "unicorn")
]

