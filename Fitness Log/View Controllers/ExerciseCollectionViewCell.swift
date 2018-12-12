//
//  ExerciseCollectionViewCell.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/10/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    
    
    
    private func updateViews() {
        if let exercise = exercise {
            firstLabel.text = exercise.name
            secondLabel.text = "\(exercise.reps) reps"
            thirdLabel.text = "\(exercise.sets) sets"
            fourthLabel.text = "\(exercise.weight) lbs"
        } else if let meal = meal  {
            
        }
    }
    
    var exercise: Exercise? {
        didSet {
            updateViews()
        }
    }
    
    var meal: Meal? {
        didSet {
            updateViews()
        }
    }
}
