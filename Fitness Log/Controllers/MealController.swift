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
    
    func createMeal(name: String, calories: Int16, protein: Int16, carbs: Int16) -> Meal {
        let meal = Meal(name: name, calories: calories, protein: protein, carbs: carbs)
        meals.append(meal)
        CoreDataController.saveToPersistent()
        return meal
    }
    
    
    private(set) var meals: [Meal] = []
    
}
