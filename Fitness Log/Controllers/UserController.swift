//
//  UserController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    func createUser(age: Int16, activityLevel: String, weight: Int16, gender: String, maintenanceCalories: Int16, height: Int16, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) -> User {
        let user = User(age: age, activityLevel: activityLevel, weight: weight, gender: gender, maintenanceCalories: maintenanceCalories, height: height)
        CoreDataController.saveToPersistent()
        return user
    }
    
    func addEntry(user: User, entry: Entry) {
        user.addToEntries(entry)
        CoreDataController.saveToPersistent()
    }
    
}
