//
//  AllIngredientsViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/23/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class AllIngredientsViewController: UITableViewController {
    var allIngredients2: [Ingredient] = []
    var allProducts: [Product] = []
}

extension AllIngredientsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shopping List"
        
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension AllIngredientsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIngredients2.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientTableViewCell
        
        let product = allProducts.first(where: {$0.name == allIngredients2[indexPath.row].productName})
        
        cell.populate(ingredient: allIngredients2[indexPath.row], product: product!)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString = ""
        
        var currPrice = 0.0
        
        for ingredient in allIngredients2 {
            let product = allProducts.first(where: {$0.name == ingredient.productName})
            
            currPrice += ingredient.requiredQuantity * (product!.totalPrice / product!.quantity)
        }
        
        headerString = String(format: "Total price: $%0.2f", currPrice)
        
        return headerString
    }
}
