//
//  User+Convenience.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    convenience init(age: Int16, activityLevel: String, weight: Int16, gender: String, maintenanceCalories: Int16, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.maintenanceCalories = maintenanceCalories
        self.age = age
        self.activityLevel = activityLevel
        self.weight = weight
        self.gender = gender
    }
    
}
