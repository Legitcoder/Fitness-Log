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
    
    
    
    
    private func updateViews() {
        guard let exercise = exercise else { return }
    }
    
    var exercise: NSSet? {
        didSet {
            updateViews()
        }
    }
}
