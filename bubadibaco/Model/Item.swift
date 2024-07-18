//
//  Item.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 15/07/24.
//

import Foundation
import SwiftUI

struct Item: Hashable, Identifiable{
    var id = UUID()
    var name: String
    var imageName: String
    var type: Task
    var image: Image {
        Image(imageName)
    }
}

let items = [
    Item(name: "Cake", image: "cake_image", type: tasks[0]),
    Item(name: "Beef", image: "beef_image", type: tasks[0]),
    Item(name: "Corn", image: "corn_image", type: tasks[0]),
    Item(name: "Milk", image: "milk_image", type: tasks[1]),
    Item(name: "Soda", image: "soda_image", type: tasks[1]),
    Item(name: "Tea", image: "tea_image", type: tasks[1]),
    Item(name: "Ball", image: "ball_image", type: tasks[2]),
    Item(name: "Doll", image: "doll_image", type: tasks[2]),
    Item(name: "Card", image: "card_image", type: tasks[2]),
    Item(name: "Bed", image: "bed_image", type: tasks[3]),
    Item(name: "Sofa", image: "sofa_image", type: tasks[3]),
    Item(name: "Tent", image: "tent_image", type: tasks[3]),
]
