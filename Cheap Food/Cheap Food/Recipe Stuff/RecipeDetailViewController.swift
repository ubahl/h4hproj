//
//  RecipeDetailViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/23/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipeData: Recipe!
    
    var ingredientsTableView: UITableView!
    
    var allProducts: [Product]!
}

extension RecipeDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.secondarySystemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Recipe Details"
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shopping List", style: .done, target: self, action: #selector(doneButtonPressed))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.70, green:0.03, blue:0.22, alpha:1.0)
        
        buildScene()
    }
    
    func buildScene() {
        let recipeHeroImage = UIImageView(image: UIImage(named: "defaultFoodImage.jpg"))
        recipeHeroImage.contentMode = .scaleAspectFit
        self.view.addSubview(recipeHeroImage)
        recipeHeroImage.translatesAutoresizingMaskIntoConstraints = false
        
        let myImageWidth = recipeHeroImage.frame.size.width
        let myImageHeight = recipeHeroImage.frame.size.height
        let myViewWidth = self.view.frame.size.width

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        
        NSLayoutConstraint.activate([
            recipeHeroImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            recipeHeroImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            recipeHeroImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            recipeHeroImage.heightAnchor.constraint(equalToConstant: scaledHeight),
            recipeHeroImage.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        
        

        let recipeName = UILabel()
        recipeName.text = recipeData.name
        recipeName.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        recipeName.textColor = UIColor.label
        recipeName.textAlignment = .left
        self.view.addSubview(recipeName)
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: recipeHeroImage.bottomAnchor, constant: 15),
            recipeName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            recipeName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
        
        
        
        let recipeInstructions = UILabel()
        recipeInstructions.text = recipeData.instructions
        recipeInstructions.numberOfLines = 0
        recipeInstructions.font = UIFont.preferredFont(forTextStyle: .body)
        recipeInstructions.textColor = UIColor.label
        recipeInstructions.textAlignment = .left
        self.view.addSubview(recipeInstructions)
        recipeInstructions.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeInstructions.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 10),
            recipeInstructions.leadingAnchor.constraint(equalTo: recipeName.leadingAnchor),
            recipeInstructions.trailingAnchor.constraint(equalTo: recipeName.trailingAnchor),
        ])
        
        
        
        ingredientsTableView = UITableView(frame: CGRect(), style: .insetGrouped)
        ingredientsTableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "cell")
        ingredientsTableView.rowHeight = UITableView.automaticDimension
        ingredientsTableView.isScrollEnabled = false
        ingredientsTableView.dataSource=self
        ingredientsTableView.delegate=self
        self.view.addSubview(ingredientsTableView)
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ingredientsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ingredientsTableView.topAnchor.constraint(equalTo: recipeInstructions.bottomAnchor, constant: 15),
            ingredientsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData.ingredients.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientTableViewCell
        
        let product = allProducts.first(where: {$0.name == recipeData.ingredients[indexPath.row].productName})
        
        cell.populate(ingredient: recipeData.ingredients[indexPath.row], product: product!)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class IngredientTableViewCell: UITableViewCell {

    var ingredientName: UILabel!
    var ingredientQuantity: UILabel!
    var ingredientPrice: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ingredientName = UILabel()
        ingredientName.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        ingredientName.textColor = UIColor.label
        ingredientName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(ingredientName)
        
        NSLayoutConstraint.activate([
            ingredientName.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            ingredientName.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
        
        ingredientQuantity = UILabel()
        ingredientQuantity.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ingredientQuantity.textColor = UIColor.secondaryLabel
        ingredientQuantity.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(ingredientQuantity)
        
        NSLayoutConstraint.activate([
            ingredientQuantity.topAnchor.constraint(equalTo: ingredientName.bottomAnchor, constant: 5),
            ingredientQuantity.leadingAnchor.constraint(equalTo: ingredientName.leadingAnchor),
            ingredientQuantity.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
        
        ingredientPrice = UILabel()
        ingredientPrice.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ingredientPrice.textColor = UIColor.secondaryLabel
        ingredientPrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(ingredientPrice)
        
        NSLayoutConstraint.activate([
            ingredientPrice.topAnchor.constraint(equalTo: ingredientName.topAnchor),
            ingredientPrice.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    func populate(ingredient: Ingredient, product: Product) {
        ingredientName.text = ingredient.productName
        
        ingredientPrice.text = String(format: "$%0.2f", ingredient.requiredQuantity * (product.totalPrice / product.quantity))
        
        ingredientQuantity.text = String(format: "%0.1f %@", ingredient.requiredQuantity, product.quantityUnit)
    }
}
