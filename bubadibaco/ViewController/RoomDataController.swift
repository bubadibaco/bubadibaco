//
//  RoomDataController.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 18/07/24.
//

import Foundation
import Combine

class RoomData: ObservableObject {
    @Published var items: [Item]

    init(items: [Item] = []) {
        self.items = items
    }
}

