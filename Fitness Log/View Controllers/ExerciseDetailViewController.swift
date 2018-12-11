//
//  ExerciseDetailViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/10/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func saveExercise(_ sender: Any) {
        guard let name = nameTextField.text,
        let reps = repsTextField.text,
        let sets = setsTextField.text,
        let weight = weightTextField.text,
        let selectedDate = selectedDate else { return }
        if let entry = entry {
            let exercise = exerciseController?.createExercise(name: name, weight: Int16(weight)!, reps: Int16(reps)!, sets: Int16(sets)!)
            entryController?.addExercise(entry: entry, exercise: exercise!)
        } else {
            let entry = (entryController?.createEntry(date: selectedDate))!
            let exercise = exerciseController?.createExercise(name: name, weight: Int16(weight)!, reps: Int16(reps)!, sets: Int16(sets)!)
            entryController?.addExercise(entry: entry, exercise: exercise!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    var entryController: EntryController?
    var exerciseController: ExerciseController?
    var selectedDate: Date?
    var entry: Entry?
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
