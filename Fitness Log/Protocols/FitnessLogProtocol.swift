//
//  FitnessLogProtocol.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

protocol FitnessLogProtocol {
    var exerciseController: ExerciseController? {get set}
    var entryController: EntryController? {get set}
    var mealController: MealController? {get set}
    var userController: UserController? {get set}
}
