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
    Item(name: "Tea", image: "tea_image", sound: "tea_sound", type: tasks[1]),
    Item(name: "Ball", image: "ball_image", sound: "ball_sound", type: tasks[2]),
    Item(name: "Doll", image: "doll_image", sound: "doll_sound", type: tasks[2]),
    Item(name: "Card", image: "card_image", sound: "card_sound", type: tasks[2]),
    Item(name: "Bed", image: "bed_image", sound: "bed_sound", type: tasks[3]),
    Item(name: "Sofa", image: "sofa_image", sound: "sofa_sound", type: tasks[3]),
    Item(name: "Tent", image: "tent_image", sound: "tent_sound", type: tasks[3]),
]

var randomObjects = [
    Item(name: "Flower", image: "flower_image", sound: "", type: nil),
    Item(name: "Books", image: "books_image", sound: "", type: nil),
    Item(name: "Comb", image: "comb_image", sound: "comb_sound", type: nil),
    Item(name: "Pan", image: "pan_image", sound: "comb_sound", type: nil),
    Item(name: "Soap", image: "soap_image", sound: "", type: nil),
    Item(name: "Oven", image: "oven_image", sound: "comb_sound", type: nil),
    Item(name: "Toothpaste", image: "toothpaste_image", sound: "", type: nil),
    Item(name: "Toothbrush", image: "toothbrush_image", sound: "", type: nil),
    Item(name: "Candle", image: "candle_image", sound: "", type: nil),
    Item(name: "Shampoo", image: "shampoo_image", sound: "", type: nil),
    Item(name: "LiquidSoap", image: "liquidsoap_image", sound: "", type: nil),
    Item(name: "Brush", image: "brush_image", sound: "", type: nil),
    Item(name: "Duck", image: "duck_image", sound: "", type: nil),
    Item(name: "Razor", image: "razor_image", sound: "", type: nil),
    Item(name: "Clock", image: "clock_image", sound: "", type: nil),
    Item(name: "Cat", image: "cat_image", sound: "", type: nil),
    Item(name: "Plant", image: "plant_image", sound: "", type: nil),
    Item(name: "Jar", image: "jar_image", sound: "", type: nil),
    Item(name: "Cup", image: "cup_image", sound: "", type: nil),
    Item(name: "Jug", image: "jug_image", sound: "", type: nil),
    Item(name: "Eggs", image: "eggs_image", sound: "", type: nil),
    Item(name: "Radio", image: "radio_image", sound: "", type: nil),
    Item(name: "Ramen", image: "ramen_image", sound: "", type: nil),
    Item(name: "Bag", image: "bag_image", sound: "", type: nil),
    Item(name: "Novel", image: "novel_image", sound: "", type: nil),
    Item(name: "Telescope", image: "telescope_image", sound: "", type: nil)
]
