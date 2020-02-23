//
//  FoodDetailViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/22/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
   var foodData: FoodItem!
}

extension FoodDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.secondarySystemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = foodData.name
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.70, green:0.03, blue:0.22, alpha:1.0)
        
        buildScene()
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func buildScene() {

        let groupName = UILabel()
        groupName.text = foodData.name
        groupName.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        groupName.textColor = UIColor.label
        groupName.textAlignment = .left
        self.view.addSubview(groupName)
        groupName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            groupName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            groupName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
        
        
        
        let groupDescription = UILabel()
        groupDescription.numberOfLines = 0
        groupDescription.font = UIFont.preferredFont(forTextStyle: .body)
        groupDescription.textColor = UIColor.label
        groupDescription.textAlignment = .left
        self.view.addSubview(groupDescription)
        groupDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupDescription.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 10),
            groupDescription.leadingAnchor.constraint(equalTo: groupName.leadingAnchor),
            groupDescription.trailingAnchor.constraint(equalTo: groupName.trailingAnchor),
        ])
        
        if (foodData.safewayPrice <= foodData.walmartPrice) {
            groupDescription.text = String(format: "Safeway Price: $%0.2f", foodData.safewayPrice)
        } else {
            groupDescription.text = String(format: "Walmart Price: $%0.2f", foodData.walmartPrice)
        }
    }
}
