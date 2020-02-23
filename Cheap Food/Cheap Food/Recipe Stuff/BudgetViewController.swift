//
//  BudgetViewController.swift
//  Cheap Food
//
//  Created by Reece Carolan on 2/23/20.
//  Copyright © 2020 HelloStudios. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {
    var weeklyBudget: Double!
}

extension BudgetViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.secondarySystemBackground
        self.title = "Enter Budget"
        
        let budgetTextField = UITextField()
        budgetTextField.placeholder = "Enter your weekly food budget"
        budgetTextField.font = UIFont.systemFont(ofSize: 15)
        budgetTextField.borderStyle = UITextField.BorderStyle.roundedRect
        budgetTextField.autocorrectionType = UITextAutocorrectionType.no
        budgetTextField.keyboardType = UIKeyboardType.decimalPad
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
        let vc = RecipeViewController()
        
        vc.weeklyBudget = weeklyBudget
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BudgetViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        weeklyBudget = NumberFormatter().number(from: textField.text!)!.doubleValue
    }
}


extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Get Meal Plan", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        toolbar.tintColor = UIColor(red:0.70, green:0.03, blue:0.22, alpha:1.0)

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
