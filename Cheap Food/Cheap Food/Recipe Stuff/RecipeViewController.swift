//
//  RecipeViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class RecipeViewController: UIViewController {
    var weeklyBudget: Double!
    
    
    
    var swipeMenuView: SwipeMenuView!
    
    
    
    struct Recipes: Codable{
        var allBreakfastRecipes: [Recipe] = []
        var allLunchRecipes: [Recipe] = []
        var allDinnerRecipes: [Recipe] = []
    }
    var recipes = Recipes()
    
    struct Products: Codable{
        var allProducts: [Product] = []
    }
    var products = Products()
    
    
    
    var finalRecipes: [[Recipe]] = [[], [], []]
}

extension RecipeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.secondarySystemBackground
        //self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Recipes"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shopping List", style: .done, target: self, action: #selector(doneButtonPressed))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.70, green:0.03, blue:0.22, alpha:1.0)
        
        recipes = loadRecipes()!
        products = loadProducts()!
        
        calculateRecipesForBudget(budget: weeklyBudget)
        
        
        swipeMenuView = SwipeMenuView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), options: .init())
        view.addSubview(swipeMenuView)
        
        swipeMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeMenuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            swipeMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            swipeMenuView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            swipeMenuView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self

        swipeMenuView.reloadData(options: .init())
    }
    
    @objc func doneButtonPressed() {
        
        var allIngredients: [Ingredient] = []
        
        for mealType in finalRecipes {
            for recipe in mealType {
                for ingredient in recipe.ingredients {
                    if let existingIngredient = allIngredients.firstIndex(where: {$0.productName == ingredient.productName}) {
                        allIngredients[existingIngredient].requiredQuantity += ingredient.requiredQuantity
                    } else {
                        let thing = ingredient
                        allIngredients.append(thing)
                    }
                }
            }
        }
        
        let vc = AllIngredientsViewController(style: .insetGrouped)
        
        vc.allIngredients2.removeAll()
        
        vc.allIngredients2 = allIngredients
        vc.allProducts = products.allProducts
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func calculateRecipesForBudget(budget: Double) {
        let mealPrice = budget / 3.0
        
        recipes.allBreakfastRecipes.sort { lhs, rhs in lhs.getPrice(products: products.allProducts) < rhs.getPrice(products: products.allProducts) }
        recipes.allLunchRecipes.sort { lhs, rhs in lhs.getPrice(products: products.allProducts) < rhs.getPrice(products: products.allProducts) }
        recipes.allDinnerRecipes.sort { lhs, rhs in lhs.getPrice(products: products.allProducts) < rhs.getPrice(products: products.allProducts) }
        
        var currWeekPrice = 9999.0
        var indecies: [Int] = []
        while currWeekPrice > mealPrice {
            currWeekPrice = 0.0
            indecies = []
//            print("hey1")
            
            for dayOfWeek in 0 ..< 7 {
//                print("hey2")
                let recipeIndex = Int.random(in: 0 ..< recipes.allBreakfastRecipes.count)
                indecies.append(recipeIndex)
                currWeekPrice += recipes.allBreakfastRecipes[recipeIndex].getPrice(products: products.allProducts)
            }
        }
        
        for dayOfWeek in 0 ..< 7 {
            finalRecipes[0].append(recipes.allBreakfastRecipes[indecies[dayOfWeek]])
        }
        
        
        
        currWeekPrice = 9999.0
        while currWeekPrice > mealPrice {
            currWeekPrice = 0.0
            indecies = []
//            print("hey3")
            for dayOfWeek in 0 ..< 7 {
//                print("hey4")
                let recipeIndex = Int.random(in: 0 ..< recipes.allLunchRecipes.count)
                indecies.append(recipeIndex)
                currWeekPrice += recipes.allLunchRecipes[recipeIndex].getPrice(products: products.allProducts)
            }
        }
        
        for dayOfWeek in 0 ..< 7 {
            finalRecipes[1].append(recipes.allLunchRecipes[indecies[dayOfWeek]])
        }
        
        
        
        currWeekPrice = 9999.0
        while currWeekPrice > mealPrice {
            currWeekPrice = 0.0
            indecies = []
            
            for dayOfWeek in 0 ..< 7 {
                let recipeIndex = Int.random(in: 0 ..< recipes.allDinnerRecipes.count)
                indecies.append(recipeIndex)
                currWeekPrice += recipes.allDinnerRecipes[recipeIndex].getPrice(products: products.allProducts)
            }
        }
        
        for dayOfWeek in 0 ..< 7 {
            finalRecipes[2].append(recipes.allDinnerRecipes[indecies[dayOfWeek]])
        }
    }
}

extension RecipeViewController: SwipeMenuViewDelegate {

    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
}

extension RecipeViewController: SwipeMenuViewDataSource {

    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 3
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        let array = ["Breakfast", "Lunch", "Dinner"]
        return array[index]
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        let vc = RecipeTableViewController(style: .insetGrouped)
        
        vc.allRecipes = finalRecipes[index]
        vc.allProducts = products.allProducts
        
        self.addChild(vc)
        
        return vc
    }
}
