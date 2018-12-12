//
//  MealCollectionViewCell.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/10/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var mealCaloriesLabel: UILabel!
    
    @IBOutlet weak var mealCarbsLabel: UILabel!
    
    @IBOutlet weak var mealProteinLabel: UILabel!
    
    private func updateViews() {
        guard let meal = meal else { return }
        
        mealNameLabel.text = meal.name
        mealCaloriesLabel.text = "Calories: \(meal.calories)"
        mealCarbsLabel.text = "Carbs:   \(meal.carbs)g"
        mealProteinLabel.text = "Protein: \(meal.protein)g"
    }
    
    var meal: Meal? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
}
