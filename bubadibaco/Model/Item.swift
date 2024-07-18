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
    var name : String
    var imageName : String
    var type : Task
    
    var image: Image {
            Image(imageName)
        }
}
