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
                if var initialVC = navVC.topViewController as? ExerciseControllerProtocol {
                    initialVC.exerciseController = exerciseController
                }
            }
            if var childVC = childVC as? UserControllerProtocol {
                childVC.userController = userController
            }
        }
    }
    
    let exerciseController = ExerciseController()
    let userController = UserController()
    let sessionController = SessionController()
    let mealController = MealController()

}
