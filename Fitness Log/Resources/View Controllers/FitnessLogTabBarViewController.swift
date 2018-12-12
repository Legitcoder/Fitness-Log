//
//  TabBarViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

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
                } else if var caloriesVC = navVC.topViewController as? UserControllerProtocol {
                    caloriesVC.userController = userController
                }
            }
        }
    }
    
    let exerciseController = ExerciseController()
    let userController = UserController()
    let entryController = EntryController()
    let mealController = MealController()

}
