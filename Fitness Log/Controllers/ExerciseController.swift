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
    
    private func createExercise(name: String, reps: Int16, sets: Int16) {
        let exercise = Exercise(name: name, reps: reps, sets: sets)
        exercises.append(exercise)
        CoreDataController.saveToPersistent()
    }
    
    
    private(set) var exercises: [Exercise] = []
    
}
