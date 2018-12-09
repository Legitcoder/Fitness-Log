//
//  MealController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

class MealController {
    
    private func createMeal(calories: Int16, protein: Int16, carbs: Int16) {
        let meal = Meal(calories: calories, protein: protein, carbs: carbs)
        meals.append(meal)
        CoreDataController.saveToPersistent()
    }
    
    
    private(set) var meals: [Meal] = []
    
}
