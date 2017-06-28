//
//  CourseNotesViewController.swift
//  PageTheScroll
//
//  Created by Sammy Alhashemi on 2017-06-16.


import UIKit
import FSCalendar

class CourseNotesViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var CourseTitle: String?
    
    @IBOutlet weak var CourseNameLabel: UILabel!
    
    @IBOutlet weak var CalendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        CourseNameLabel.text = CourseTitle
        
        CalendarView.dataSource = self
        CalendarView.delegate = self
        CalendarView.scrollEnabled = true
        CalendarView.scrollDirection = .horizontal
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // code
        
    }
    
}

extension CourseNotesViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CourseNotesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

