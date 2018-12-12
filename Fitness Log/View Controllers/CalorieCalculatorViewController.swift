//
//  CalorieCalculatorViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class CalorieCalculatorViewController: UIViewController, UserControllerProtocol {
    
    
    @IBAction func chooseGender(_ sender: DLRadioButton) {
        if sender.tag == 1 {
            print("Male")
        } else if sender.tag == 2 {
            print("Female")
        }
    }
    
    
    var userController: UserController? {
        didSet {
            print(userController!)
        }
    }

}
