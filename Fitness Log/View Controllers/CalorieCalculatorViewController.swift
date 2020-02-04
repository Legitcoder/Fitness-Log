
//
//  CalorieCalculatorViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//
import UIKit
import DLRadioButton
class CalorieCalculatorViewController: UIViewController, UserProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.isHidden = isHidden
        updateViews()
    }
    var isHidden: Bool = true
    @IBOutlet weak var buttonDrop: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var maintenanceCaloriesLabel: UILabel!
    
    @IBOutlet weak var heightFeetTextField: UITextField!
    
    @IBOutlet weak var heightInchesTextField: UITextField!
    
    @IBOutlet weak var maleRadioButton: DLRadioButton!
    
    @IBOutlet weak var femaleRadioButton: DLRadioButton!
    
    
    var gender = Gender.Male
    var activityLevels = [ActivityLevel.Sedentary.rawValue, ActivityLevel.Light.rawValue, ActivityLevel.Moderate.rawValue, ActivityLevel.Intense.rawValue]
    
    @IBAction func chooseGender(_ sender: DLRadioButton) {
        gender = sender.tag == 1 ? Gender.Male :  Gender.Female
    }
    func updateViews() {
        guard let user = user, isViewLoaded else {
            NSLog("Optional User in CalorieCalculatorViewController wasn't Set")
            return
        }
        
        let feet = "\(user.height / 12)"
        let inches = "\(user.height % 12)"
        ageTextField.text = "\(user.age)"
        heightFeetTextField.text = feet
        heightInchesTextField.text = inches
        weightTextField.text = "\(user.weight)"
        buttonDrop.setTitle(user.activityLevel, for: .normal)
        maintenanceCaloriesLabel.text = "\(user.maintenanceCalories) Calories"
        
        switch user.gender {
        case Gender.Male.rawValue:
            maleRadioButton.isSelected = true
        case Gender.Female.rawValue:
            femaleRadioButton.isSelected = true
        default:
            return
        }
    }
    
    func weightInKG(weight: Int16) -> Double {
            return Double(weight) * 0.45359237
    }
    
    func heightInCm(inches: Int16) -> Double {
        return (Double(inches)/0.39370)
    }
    
    func calculatorBMR(weight: Int16, height: Int16, age: Int16) -> Double {
        if gender == .Male {
            let bmr = (10.0 * Double(weight)) + (6.25 * Double(height)) - (5.0 * Double(age)) + 5.0
            return bmr
        }
        else {
            let bmr = (10.0 * Double(weight)) + (6.25 * Double(height)) - (5.0 * Double(age)) - 161.0
            return bmr
        }
    }
    
    func calculateActivityLevelMultiplier(activityLevel: String) -> Double {
        switch buttonDrop.titleLabel?.text {
        case ActivityLevel.Sedentary.rawValue:
            return 1.2
        case ActivityLevel.Light.rawValue:
            return 1.375
        case ActivityLevel.Moderate.rawValue:
            return 1.55
        case ActivityLevel.Intense.rawValue:
            return 1.725
        default:
            return 0
            
        }
    }
    
    @IBAction func saveMaintenanceCalories(_ sender: Any) {
        guard let age = ageTextField.text,
            let feet = heightFeetTextField.text,
            let inches = heightInchesTextField.text,
            let activityLevel = buttonDrop.titleLabel?.text,
            let weight = weightTextField.text
            else { return }
        let heightInInches = (Int16(feet)! * 12) + Int16(inches)!
        let heightCm = heightInCm(inches: heightInInches)
        let weightKg = weightInKG(weight: Int16(weight)!)
        let BMR = calculatorBMR(weight: Int16(weightKg), height: Int16(heightCm), age: Int16(age)!)
        let multiplier = calculateActivityLevelMultiplier(activityLevel: activityLevel)
        let maintenance = BMR * multiplier
        if let user = user {
            //Update Current User attributes
            userController?.updateUser(user: user, age: Int16(age)!, activityLevel: activityLevel, weight: Int16(weight)!, gender: gender.rawValue, maintenanceCalories: Int16(maintenance), height: heightInInches)
            updateViews()
        } else {
            //Create New User
            let user = userController?.createUser(age: Int16(age)!, activityLevel: activityLevel, weight: Int16(weight)!, gender: gender.rawValue, maintenanceCalories: Int16(maintenance), height: heightInInches)
            self.user = user
            updateViews()
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
