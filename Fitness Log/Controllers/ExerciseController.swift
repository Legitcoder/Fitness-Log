//
//  ExerciseController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

class ExerciseController {
    
//    init() {
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
//        let request = NSBatchDeleteRequest(fetchRequest: fetch)
//
//        do {
//            let result = try CoreDataStack.shared.mainContext.execute(request)
//        }
//        catch {
//            NSLog("\(error)")
//        }
//    }
    
    func createExercise(name: String, weight: Int16, reps: Int16, sets: Int16) -> Exercise {
        let exercise = Exercise(name: name, weight: weight, reps: reps, sets: sets)
        exercises.append(exercise)
        CoreDataController.saveToPersistent()
        return exercise
    }
    
    
    private(set) var exercises: [Exercise] = []
    
}
