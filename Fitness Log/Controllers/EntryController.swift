//
//  SessionController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    func createEntry(date: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) -> Entry {
        let entry = Entry(date: date)
        CoreDataController.saveToPersistent()
        return entry
    }
    
    func addMeal(entry: Entry, meal: Meal) {
        entry.addToMeals(meal)
        CoreDataController.saveToPersistent()
    }
    
    func addExercise(entry: Entry, exercise: Exercise) {
        entry.addToExercises(exercise)
        CoreDataController.saveToPersistent()
    }
    
    
}
