//
//  Item.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 15/07/24.
//

import Foundation

struct Item: Hashable, Identifiable {
    var id = UUID()
    var name : String
    var image : String
    var sound : String
    var type : Task?
}

var items = [
    Item(name: "Cake", image: "cake_image", sound: "cake_sound", type: tasks[0]),
    Item(name: "Beef", image: "beef_image", sound: "beef_sound", type: tasks[0]),
    Item(name: "Corn", image: "corn_image", sound: "corn_sound", type: tasks[0]),
    Item(name: "Milk", image: "milk_image", sound: "milk_sound", type: tasks[1]),
    Item(name: "Soda", image: "soda_image", sound: "soda_sound", type: tasks[1]),
    Item(name: "Tea", image: "cup_image", sound: "tea_sound", type: tasks[1]),
    Item(name: "Ball", image: "ball_image", sound: "ball_sound", type: tasks[2]),
    Item(name: "Doll", image: "doll_image", sound: "doll_sound", type: tasks[2]),
    Item(name: "Card", image: "card_image", sound: "card_sound", type: tasks[2]),
    Item(name: "Bed", image: "bed_image", sound: "bed_sound", type: tasks[3]),
    Item(name: "Sofa", image: "sofa_image", sound: "sofa_sound", type: tasks[3]),
    Item(name: "Tent", image: "tent_image", sound: "tent_sound", type: tasks[3]),
]

var randomObjects = [
    Item(name: "Flower", image: "flower_image", sound: "flower_sound", type: nil),
    Item(name: "Books", image: "books_image", sound: "books_sound", type: nil),
    Item(name: "Book", image: "books2_image", sound: "books2_sound", type: nil),
    Item(name: "Egg", image: "egg_image", sound: "egg_sound", type: nil),
    Item(name: "Radio", image: "radio_image", sound: "radio_sound", type: nil),
    Item(name: "Kettle", image: "teko_image", sound: "teko_sound", type: nil),
    Item(name: "Jar", image: "toples_image", sound: "toples_sound", type: nil),
    Item(name: "Bag", image: "bag_image", sound: "bag_sound", type: nil),
    Item(name: "Cat", image: "cat_image", sound: "cat_sound", type: nil),

//    Item(name: "Comb", image: "comb_image", sound: "comb_sound", type: nil),
//    Item(name: "Pan", image: "pan_image", sound: "pan_sound", type: nil),
//    Item(name: "Soap", image: "soap_image", sound: "soap_sound", type: nil),
//    Item(name: "Oven", image: "oven_image", sound: "oven_sound", type: nil),

]
