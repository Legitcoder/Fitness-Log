//
//  CalorieCalculatorViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class CalorieCalculatorViewController: UIViewController, UserControllerProtocol {
    
    var userController: UserController? {
        didSet {
            print(userController!)
        }
    }

}
