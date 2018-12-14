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
                if var initialVC = navVC.topViewController as? FitnessLogProtocol {
                    initialVC.exerciseController = exerciseController
                    initialVC.mealController = mealController
                    initialVC.entryController = entryController
                    initialVC.userController = userController
                } else if var caloriesVC = navVC.topViewController as? UserProtocol {
                    caloriesVC.userController = userController
                    if let user = user {
                        caloriesVC.user = user
                    }
                }
            }
        }
    }
    
    var user: User? {
        return users.first
    }
    
    var users: [User] {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching users from moc: \(error)")
            return []
        }
    }
    
    
    
    let exerciseController = ExerciseController()
    let userController = UserController()
    let entryController = EntryController()
    let mealController = MealController()

}
