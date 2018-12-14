//
//  CalorieCalculatorViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class CalorieCalculatorViewController: UIViewController, UserControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.isHidden = isHidden
    }
    var isHidden: Bool = true
    @IBOutlet weak var buttonDrop: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var heightFeetTextField: UITextField!
    
    @IBOutlet weak var heightInchesTextField: UITextField!
    
    var gender: String = "Male"
    var activityLevels = ["\(ActivityLevel.Sedentary)\n(No Exercise)", "\(ActivityLevel.Light)\n(1-3 Days)", "\(ActivityLevel.Moderate)\n(3-4 Days)", "\(ActivityLevel.Intense)\n(5-7 Days)"]
    
    @IBAction func chooseGender(_ sender: DLRadioButton) {
        gender = sender.tag == 1 ? "Male" : "Female"
    }
    func updateViews() {
        guard let user = user else {
            NSLog("Optional User in CalorieCalculatorViewController wasn't Set")
            return
        }
        let feet = "\(user.height / 12)"
        let inches = "\(user.height % 12)"
        ageTextField.text = "\(user.age)"
        heightFeetTextField.text = feet
        heightInchesTextField.text = inches
        buttonDrop.setTitle(user.activityLevel, for: .normal)
    }
    
    func weightInKG(weight: Int16) -> Double {
            return Double(weight) * 0.45359237
    }
    
    func heightInCm(inches: Int16) -> Double {
        return (Double(inches)/0.39370)
    }
    
    func calculatorBMR(weight: Int16, height: Int16, age: Int16) -> Double {
        if gender == "Male" {
            let bmr = (10.0 * Double(weight)) + (6.25 * Double(height)) - (5.0 * Double(age)) + 5.0
            return bmr
        }
        else {
            let bmr = (10.0 * Double(weight)) + (6.25 * Double(height)) - (5.0 * Double(age)) - 161.0
            return bmr
        }
    }
    
    func calculateActivityLevelMultiplier() -> Double {
        return 0.05
    }
    
    @IBAction func saveMaintenanceCalories(_ sender: Any) {
        if let user = user {
            
        } else {
            //Create New User
            guard let age = ageTextField.text,
                let feet = heightFeetTextField.text,
                let inches = heightInchesTextField.text,
                let activityLevel = buttonDrop.titleLabel?.text,
                let weight = weightTextField.text
                else { return }
            let heighInInches = (Int16(feet)! * 12) + Int16(inches)!
            let heightCm = heightInCm(inches: heighInInches)
            let weightKg = weightInKG(weight: Int16(weight)!)
            let BMR = calculatorBMR(weight: Int16(weightKg), height: Int16(heightCm), age: Int16(age)!)
            userController?.createUser(age: Int16(age)!, activityLevel: activityLevel, weight: Int16(age)!, gender: gender, maintenanceCalories: 23, height: heighInInches)
        }
    }
    
    
    @IBAction func onClickDropButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = !self.isHidden
        }
        isHidden = !isHidden
    }
    
    
            
        
    var userController: UserController?
    
    var user: User? {
        didSet {
            updateViews()
        }
    }

}

extension CalorieCalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityLevels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = activityLevels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activityLevel = activityLevels[indexPath.row]
        buttonDrop.setTitle(activityLevel, for: .normal)
        onClickDropButton(self)
    }
    
    
}


