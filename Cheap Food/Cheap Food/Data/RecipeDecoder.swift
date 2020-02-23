//
//  DataCreation.swift
//  MacTracker
//
//  Created by Reece Carolan on 1/15/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import Foundation

extension RecipeViewController {
    func decode(data: Data) throws -> Recipes? {
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(Recipes.self, from: data)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func decode2(data: Data) throws -> Products? {
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(Products.self, from: data)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }

    func loadRecipes() -> Recipes? {
        guard let fileURL = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            print("couldn't find the file")
            return nil
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            let user = try decode(data: content)
            return user

        } catch let error {
            print(error)
            return nil
        }
    }
    
    func loadProducts() -> Products? {
        guard let fileURL = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("couldn't find the file")
            return nil
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            let user = try decode2(data: content)
            return user

        } catch let error {
            print(error)
            return nil
        }
    }
}

extension ViewController {
    func decode(data: Data) throws -> ItemType? {
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(ItemType.self, from: data)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }

    func loadRecipes() -> ItemType? {
        guard let fileURL = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            print("couldn't find the file")
            return nil
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            let user = try decode(data: content)
            return user

        } catch let error {
            print(error)
            return nil
        }
    }
}

