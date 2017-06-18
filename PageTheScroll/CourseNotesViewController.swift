//
//  CourseNotesViewController.swift
//  PageTheScroll
//
//  Created by Sammy Alhashemi on 2017-06-16.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import UIKit

class CourseNotesViewController: UIViewController {
    
    var CourseTitle: String?
    
    @IBOutlet weak var CourseNameLabel: UILabel!
    
    @IBOutlet weak var CourseToDoListLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        CourseNameLabel.text = CourseTitle
        
        CourseToDoListLabel.becomeFirstResponder()
        
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

