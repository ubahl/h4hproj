//
//  Recipe.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import Foundation

class Recipe: Codable {
    
    var name: String!
    
    var instructions: String!
    
    var ingredients: [Ingredient]!
    
    func getPrice(products: [Product]) -> Double {
        var price = 0.0
        
        for ingredient in ingredients {
            let product = products.first(where: {$0.name == ingredient.productName})
            price += ingredient.requiredQuantity * (product!.totalPrice / product!.quantity)
        }
        
        return price
    }
}
