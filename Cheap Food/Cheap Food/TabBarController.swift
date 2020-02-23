//
//  TabBarController.swift
//  HelloCampus
//
//  Created by Reece Carolan on 2/19/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        getStuff()
        
        let vc = ViewController()
        
        let homeTab = UINavigationController(rootViewController: vc)
        homeTab.navigationBar.prefersLargeTitles = true
        homeTab.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        
        
        let vc2 = BudgetViewController()
        
        let recipeTab = UINavigationController(rootViewController: vc2)
        recipeTab.navigationBar.prefersLargeTitles = true
        recipeTab.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(named: "TabBar_Bookmark.png"), tag: 0)

        
        
        let tabBarList = [recipeTab, homeTab]

        viewControllers = tabBarList
        self.tabBar.tintColor = UIColor(red:0.70, green:0.03, blue:0.22, alpha:1.0)
    }
    
    func postStuff() {
        let parameters: [String: [String]] = [
            "items": ["apple", "milk", "brita"],
        ]
        
        

        //create the url with URL
        let url = URL(string: "https://4y41287l84.execute-api.us-west-1.amazonaws.com/test1/accessitem")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    func getStuff() {
        let parameters: [String: [String]] = [
            "items": ["chair", "gord", "the letter 3"],
        ]
        
        

        //create the url with URL
        let url = URL(string: "https://4y41287l84.execute-api.us-west-1.amazonaws.com/test1/scrapeitem")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
