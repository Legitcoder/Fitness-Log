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
    
    var activityLevels = ["Sedentary", "Light", "Moderate", "Intense"]
    
    @IBAction func chooseGender(_ sender: DLRadioButton) {
        if sender.tag == 1 {
            print("Male")
        } else if sender.tag == 2 {
            print("Female")
        }
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = !self.isHidden
        }
        isHidden = !isHidden
    }
            
        
    var userController: UserController? {
        didSet {
            print(userController!)
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


