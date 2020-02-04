//
//  TabBarViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import CoreData

class FitnessLogTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        passControllersToChildViewControllers()
    }
    
    func passControllersToChildViewControllers() {
        for childVC in children {
            if let navVC = childVC as? UINavigationController {
                //To Collection View of All Workouts Tab(Default Initial Tab)
                if var initialVC = navVC.topViewController as? FitnessLogProtocol {
                    initialVC.exerciseController = exerciseController
                    initialVC.mealController = mealController
                    initialVC.entryController = entryController
                    initialVC.userController = userController
                } else if var caloriesVC = navVC.topViewController as? UserProtocol {
                    //To Edit Maintenance Calories Tab
                    caloriesVC.userController = userController
                    caloriesVC.user = user
                }
            }
        }
    }
    

    //Creates Initial User if it doesn't exist
    //TODO: Have it so a pop up forces User to enter information if User doesn't exist
    //in other words, it's their first time using the application
    var user: User {
        return users.first ?? userController.createUser(age: 25, activityLevel: ActivityLevel.Moderate.rawValue, weight: 170, gender: Gender.Male.rawValue, maintenanceCalories: 3000, height: 69)
    }
    
    var users: [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching User")
            return []
        }
    }
    
    
    
    let exerciseController = ExerciseController()
    let userController = UserController()
    let entryController = EntryController()
    let mealController = MealController()

}
