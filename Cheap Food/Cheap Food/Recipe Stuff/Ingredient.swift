//
//  Ingredient.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import Foundation

struct Ingredient: Codable {
    
    var productName: String!
    
    ///Amount of the item that this store sells. Standardized to gallon, pound, or single item (one egg, one banana, etc)
    var requiredQuantity: Double!
}
