//
//  ExerciseCollectionViewCell.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/10/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseRepsLabel: UILabel!
    @IBOutlet weak var exerciseSetsLabel: UILabel!
    @IBOutlet weak var exerciseWeightLabel: UILabel!
    
    
    
    
    private func updateViews() {
        guard let exercise = exercise else  {
            NSLog("Exercise wasn't set in ExerciseCollectionViewCell")
            return
        }
        exerciseNameLabel.text = exercise.name
        exerciseRepsLabel.text = "\(exercise.reps) reps"
        exerciseSetsLabel.text = "\(exercise.sets) sets"
        exerciseWeightLabel.text = "\(exercise.weight) lbs"
    }
    
    var exercise: Exercise? {
        didSet {
            updateViews()
        }
    }
}
