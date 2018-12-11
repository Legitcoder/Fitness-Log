//
//  Meal+Convenience.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

extension Meal {
    
    convenience init(name: String, calories: Int16, protein: Int16, carbs: Int16, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
    }
    
}

