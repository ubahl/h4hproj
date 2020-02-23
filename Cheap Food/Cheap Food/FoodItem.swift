//
//  FoodItem.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import Foundation

class FoodItem: NSObject, Codable {
    
    //List of keys that can be searched
    enum ExpressionKeys: String {
        case name
        case modelNumber
        case year
    }
    
    
    
    //MARK: Properties
    @objc var name = "Food Name"
    
    var walmartPrice = 0.0
    var safewayPrice = 0.0
}
