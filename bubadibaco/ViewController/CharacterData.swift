//
//  CharacterData.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 18/07/24.
//

import Foundation
import Combine

class CharacterData: ObservableObject {
    @Published var characters: [Character]

        init(characters: [Character] = []) {
            self.characters = characters
        }
}
