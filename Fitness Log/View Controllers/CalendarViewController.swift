//
//  CalendarViewController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/11/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData
class CalendarViewController: UIViewController {

    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    
    var entries: [Entry] {
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching entry from moc: \(error)")
            return []
        }
    }
    
    var entryDates: [Date] {
        return entries.map({ $0.date! })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.ibCalendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.scrollToDate(Date(), animateScroll: false)
        setupCalendarView()
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        validCell.selectedView.isHidden = cellState.isSelected ? false : true
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func setupCalendarView() {
        //Setup Spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //Setup Labels
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMM"
        month.text = formatter.string(from: date)
    }
    
    let outsideMonthColor = UIColor.lightGray.withAlphaComponent(0.5)
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.darkGray
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = DateFormatter()
}


extension CalendarViewController: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "1900 01 01")!
        let endDate = formatter.date(from: "2200 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        if entryDates.contains(date) {
            cell.selectedView.isHidden = false
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        //handleCellSelected(view: cell, cellState: cellState)
        //handleCellTextColor(view: cell, cellState: cellState)
        let navVC = self.tabBarController?.viewControllers?.first as! UINavigationController
        let firstTab = navVC.topViewController as! FitnessLogsCollectionViewController
        firstTab.selectedDate = date
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        //handleCellSelected(view: cell, cellState: cellState)
        //handleCellTextColor(view: cell, cellState: cellState)
    }
}


extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
