//
//  MealDetailViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/10/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {

    let resizeConstant: CGFloat = 0.50
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFields: [UITextField] = [nameTextField, caloriesTextField, carbsTextField, proteinTextField]
        setupLabelSizing(textFields: textFields)
    }
    
    func setupLabelSizing(textFields: [UITextField]) {
        for textField in textFields {
            textField.font = textField.font?.withSize((textField.frame.height) * resizeConstant)
        }

    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var caloriesTextField: UITextField!
    
    @IBOutlet weak var carbsTextField: UITextField!
    
    @IBOutlet weak var proteinTextField: UITextField!
    
    @IBAction func saveMeal(_ sender: Any) {
        guard let name = nameTextField.text,
            let calories = caloriesTextField.text,
            let carbs = carbsTextField.text,
            let protein = proteinTextField.text,
            let selectedDate = selectedDate else { return }
        if let entry = entry {
            guard let meal = mealController?.createMeal(name: name, calories: Int16(calories)!, protein: Int16(protein)!, carbs: Int16(carbs)!) else { return }
            entryController?.addMeal(entry: entry, meal: meal)
        } else {
            let entry = (entryController?.createEntry(date: selectedDate))!
            guard let meal = mealController?.createMeal(name: name, calories: Int16(calories)!, protein: Int16(protein)!, carbs: Int16(carbs)!) else { return }
                entryController?.addMeal(entry: entry, meal: meal)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func updateViews() {
        
    }
    
    var entry: Entry?
    var mealController: MealController?
    var entryController: EntryController?
    var selectedDate: Date?
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
