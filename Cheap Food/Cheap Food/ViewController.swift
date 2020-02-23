//
//  ViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var itemString: [String]!
    
    struct ItemType: Codable{
        var walmart_price: String!
        var safeway_price: String!
        var item_name: String!
    }
    
    struct ItemType: Codable{
        var walmart_price: String!
        var safeway_price: String!
        var item_name: String!
    }
    
    var itemTypes: [ItemType] = []
}

extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.secondarySystemBackground
        self.title = "Search"
        
        let budgetTextField = UITextField()
        budgetTextField.placeholder = "Enter a comma seperated list of foods"
        budgetTextField.font = UIFont.systemFont(ofSize: 15)
        budgetTextField.borderStyle = UITextField.BorderStyle.roundedRect
        budgetTextField.autocorrectionType = UITextAutocorrectionType.no
        budgetTextField.keyboardType = UIKeyboardType.alphabet
        budgetTextField.returnKeyType = UIReturnKeyType.done
        budgetTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        budgetTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        budgetTextField.delegate = self
        budgetTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(budgetTextField)
        
        NSLayoutConstraint.activate([
            budgetTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            budgetTextField.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -90),
            budgetTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            budgetTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        ])
        
        budgetTextField.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
//        let vc = RecipeViewController()
//
//        vc.weeklyBudget = weeklyBudget
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        getStuff()
    }
    
    func getStuff() {
        let parameters: [String: [String]] = [
            "items": itemString,
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
            
            do {
                let user = try self.decode(data: data!)
                print(user)
                
            } catch let error {
                print(error)
            }
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try? JSONDecoder().decode(ItemType.self, from: data){
                    print(json)
                    self.itemTypes = json
                    print(self.itemTypes)
                }
                
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
    
    func pushView(type: [ItemType]) {
        print(type)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let str = textField.text?.lowercased()
        let array = str!.components(separatedBy: ", ")
        
        itemString = array
        
        print(itemString)
    }
}
