//
//  FitnessLogsCollectionViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FitnessLogsCollectionViewController: UICollectionViewController, FitnessLogProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        setTodaysDate()
        updateViews()
    }
    
    private func setTodaysDate() {
        title = formattedDate(date: self.selectedDate)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
    }
    
    private func configureTitleView() {
        let prevItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goToPreviousDay(_:)))
        
        let nextItem = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goToNextDay(_:)))
        
        navigationItem.setLeftBarButton(prevItem, animated: false)
        navigationItem.setRightBarButton(nextItem, animated: false)
    }
    
    let calendar = Calendar.current
    
    private func changeDate(dateOperator: DateOperator) -> String {
        i += dateOperator.rawValue
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        var components = DateComponents()
        components.calendar = calendar
        components.day = i
        self.selectedDate = calendar.date(byAdding: components, to: now)!
        return formattedDate(date: self.selectedDate)
    }
    
    @IBAction func goToNextDay(_ sender: Any?) {
        let newDate = changeDate(dateOperator: .increment)
        title = newDate
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, Y"
        let date = dateFormatter.string(from: date)
        return date
    }
    
    @IBAction func goToPreviousDay(_ sender: Any?) {
        let newDate = changeDate(dateOperator: .decrement)
        title = newDate
    }
    
    var i = 0

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    var selectedDate = Calendar.current.startOfDay(for: Date())
    
    var exerciseController: ExerciseController?
    
    var entryController: EntryController?
    
    var mealController: MealController?
    
    var userController: UserController?
}
