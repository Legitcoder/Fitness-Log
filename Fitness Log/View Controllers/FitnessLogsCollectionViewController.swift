//
//  FitnessLogsCollectionViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import CoreData
private let exerciseCellIdentifier = "ExerciseCell"
private let mealCellIdentifier = "MealCell"

class FitnessLogsCollectionViewController: UICollectionViewController, FitnessLogProtocol, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView.register(MealCollectionViewCell.self, forCellWithReuseIdentifier: mealIdentifier)
        configureTitleView()
        setDate()
        updateViews()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTitleView()
        setDate()
        updateViews()
    }
    
    private func setDate() {
        title = formattedDate(date: selectedDate)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        setupFetchedResultsController()
        collectionView.reloadData()
        
    }
    
    private func configureTitleView() {
        let prevItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goToPreviousDay(_:)))
        
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped(_:)))
        
        let nextItem = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goToNextDay(_:)))
        
        navigationItem.setLeftBarButton(prevItem, animated: false)
        navigationItem.setRightBarButtonItems([nextItem, rightAddBarButtonItem ], animated: false)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            goToPreviousDay(self)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            goToNextDay(self)
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New Entry", message: "What kind of entry do you want to create?", preferredStyle: .actionSheet)
        
        let mealPostAction = UIAlertAction(title: "Meal", style: .default) { (_) in
            self.performSegue(withIdentifier: "AddMeal", sender: self)
        }
        
        let exercisePostAction = UIAlertAction(title: "Exercise", style: .default) { (_) in
            self.performSegue(withIdentifier: "AddExercise", sender: self)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(mealPostAction)
        alert.addAction(exercisePostAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
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
        updateViews()
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
        updateViews()
        title = newDate
    }
    
    var i = 0

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddExercise" {
            guard let destinationVC = segue.destination as? ExerciseDetailViewController else { return }
            destinationVC.entryController = entryController
            destinationVC.exerciseController = exerciseController
            destinationVC.selectedDate = selectedDate
            if let entry = entry {
                destinationVC.entry = entry
            }
        } else if segue.identifier == "AddMeal" {
            guard let destinationVC = segue.destination as? MealDetailViewController else { return }
            destinationVC.mealController = mealController
            destinationVC.selectedDate = selectedDate
            destinationVC.entryController = entryController
            if let entry = entry {
                destinationVC.entry = entry
            }
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    var meals: [Meal] {
        let meals = entry?.meals?.allObjects as? [Meal] ?? []
        print(meals)
        return meals
    }
    
    var exercises: [Exercise] {
        let exercises = entry?.exercises?.allObjects as? [Exercise] ?? []
        return exercises
    }
    
    var entry: Entry? {
        return fetchedResultsController?.fetchedObjects?.first
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
           return  exercises.count
        } else {
            return meals.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseCellIdentifier, for: indexPath) as? ExerciseCollectionViewCell else { return UICollectionViewCell() }
            cell.exercise = exercises[indexPath.item]
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealCellIdentifier, for: indexPath) as? MealCollectionViewCell else { return UICollectionViewCell() }
            cell.meal = meals[indexPath.item]
            return cell
        }
        
        return UICollectionViewCell()
        
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

    
    

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            if indexPath.section == 0 {
                !exercises.isEmpty ? (sectionHeader.sectionHeaderlabel.text = "Exercises") : (sectionHeader.sectionHeaderlabel.text = "")
            } else {
                !meals.isEmpty ? (sectionHeader.sectionHeaderlabel.text = "Meals") : (sectionHeader.sectionHeaderlabel.text = "")
            }

            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    
    var fetchedResultsController: NSFetchedResultsController<Entry>?
    
    func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        let moc = CoreDataStack.shared.mainContext
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "date == %@", self.selectedDate as NSDate)
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        try! fetchedResultsController.performFetch()
        self.fetchedResultsController = fetchedResultsController
    }
    
    var selectedDate = Calendar.current.startOfDay(for: Date())
    
    var exerciseController: ExerciseController?
    
    var entryController: EntryController?
    
    var mealController: MealController?
    
    var userController: UserController?
}
