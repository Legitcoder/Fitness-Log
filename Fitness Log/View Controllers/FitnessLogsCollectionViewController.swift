//
//  FitnessLogsCollectionViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "ExerciseCell"

class FitnessLogsCollectionViewController: UICollectionViewController, FitnessLogProtocol, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        setDate()
        setupFetchedResultsController()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New Entry", message: "Which kind of entry do you want to create?", preferredStyle: .actionSheet)
        
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
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    var meals: [NSSet?] {
        let entries = fetchedResultsController!.fetchedObjects ?? []
        let meals = entries.map({ $0.meals })
        return meals
    }
    
    var exercises: [Exercise] {
        print(fetchedResultsController!.fetchedObjects!.count)
        let exercises = fetchedResultsController!.fetchedObjects?.first?.exercises?.allObjects as? [Exercise] ?? []
        return exercises
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if (section == 0) {
            return exercises.count
        } else {
            return meals.count
        }
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
    
    var blockOperations: [BlockOperation] = []
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Object: \(newIndexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertItems(at: [newIndexPath!])
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Object: \(indexPath)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItems(at: [indexPath!])
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.move {
            print("Move Object: \(indexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.moveItem(at: indexPath!, to: newIndexPath!)
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Object: \(indexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteItems(at: [indexPath!])
                    }
                })
            )
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                })
            )
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: BlockOperation in self.blockOperations {
                operation.start()
            }
        }, completion: { (finished) -> Void in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
    
    deinit {
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        
        blockOperations.removeAll(keepingCapacity: false)
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
