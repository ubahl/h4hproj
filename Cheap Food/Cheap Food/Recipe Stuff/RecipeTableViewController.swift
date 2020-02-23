//
//  RecipeTableViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    var allRecipes: [Recipe] = []
    var allProducts: [Product] = []
}

extension RecipeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension RecipeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! RecipeTableViewCell

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.recipeName.text = allRecipes[indexPath.row].name
        cell.recipePrice.text = String(format: "Total price: $%0.2f", allRecipes[indexPath.row].getPrice(products: allProducts))

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController()

        vc.recipeData = allRecipes[indexPath.row]
        vc.allProducts = allProducts

        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString = ""
        
        var currPrice = 0.0
        
        for recipe in allRecipes {
            currPrice += recipe.getPrice(products: allProducts)
        }
        
        headerString = String(format: "Total price: $%0.2f", currPrice)
        
        return headerString
    }
}

class RecipeTableViewCell: UITableViewCell {

    var recipeName: UILabel!
    var recipePrice: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        recipeName = UILabel()
        recipeName.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        recipeName.textColor = UIColor.label
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(recipeName)
        
        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            recipeName.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
        
        recipePrice = UILabel()
        recipePrice.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        recipePrice.textColor = UIColor.secondaryLabel
        recipePrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(recipePrice)
        
        NSLayoutConstraint.activate([
            recipePrice.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 5),
            recipePrice.leadingAnchor.constraint(equalTo: recipeName.leadingAnchor),
            recipePrice.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
    }
}
