//
//  Story.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 24/07/24.
//

import Foundation

struct Story: Codable, Identifiable {
    var id = UUID()
    var name: String
    var isUnlocked: Bool
}
