//
//  File.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import Foundation

class Product: Codable {
    
    var name: String!
    
    ///Total price of the item at the store
    var totalPrice: Double!
    
    ///Amount of the item that this store sells. Standardized to gallon, pound, or single item (one egg, one banana, etc)
    var quantity: Double!
    
    var quantityUnit: String!
}
