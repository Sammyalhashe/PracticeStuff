//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Mark Price on 7/10/16.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    // Actions
    @IBAction func buttonPressed(sender: UIButton) {
        
        
        
        PickerViewOutlet.isHidden = true
        PickerViewOutlet.isOpaque = true
        
        
        // For loop that finds what "index" the course that has already been added has in the scrollView. AKA It's position in the scrollView (As seen on the screen). We cycle through the buttons[UIButton] array defined below.
        for i in 0...(buttons.count-1) {
            if (courses[Int(sender.accessibilityIdentifier!)!] == courses[Int(buttons[i].accessibilityIdentifier!)!]) {
                buttonPress = i
            }
        }
        
        
        performSegue(withIdentifier: "SegueToToDo", sender: UIButton.self)
    }
    
    
    
    @IBAction func NavBarPlusButton(_ sender: Any) {
        
        // Plus Button on Navigation Bar was Pressed. I should unhide it
        
        PickerViewOutlet.isHidden = false
        
        /*
         // Hides the Buttons alread added to the scrollView while the PickerView is active
         for i in 0...scrollView.subviews.count {
         scrollView.subviews[i].isHidden = true
         scrollView.subviews[i].isOpaque = true
         }
         */

    }

    
    
    // Outlets
    @IBOutlet weak var PickerViewOutlet: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    // x position details
    var coursesAdded: CGFloat = 0.0 // Keeps track of the number of courses added to aid increasing x position
    
    
    
    // So far empty arrays to carry images used and buttons
    var images = [UIImageView]()
    var buttons = [UIButton]() // used ot keep track of # of buttons added (courses added) and the index of the courses as seen in the scrollView. The coursesAdded variable above would be the size of this array
    
    
    
    // courses currently thought of
    let courses = ["Classical Mechanics","Calculus","English","Programming","Algebra/Linear Algebra","Circuits/Electronics","Quantum Mechanics","Fluid Dynamics","Aerodynamics","Biology"]
    
    
    
    // dictionary version: Not Used as of yet
    let coursesDict = ["Classical Mechanics":0,"Calculus":1,"English":2,"Programming":3,"Algebra/Linear Algebra":4,"Circuits/Electronics":5,"Quantum Mechanics":6,"Fluid Dynamics":7,"Aerodynamics":8,"Biology":9]
    
    
    
    // other variables
    var buttonPress: Int? = 0
    var isEmpty: Bool? = true // Boolean keeping track if there are any courses actually added. Initially Empty
    var contentWidth: CGFloat = 0.0 // keeps track of the "Content Width" as we add and delete courses to the ScrollView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PickerViewOutlet.dataSource = self
        PickerViewOutlet.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Content Width of the Scroll View (includes all buttons added)
        
        if isEmpty! {
            contentWidth = 0.0 // If no courses, no content to actually have a width fro scrollView
        }else{
            contentWidth += 0.0
            // If not empty, keep the width of what was had before. The purpose of this is to make sure there is some content width to scroll after we come back from the ToDoList scene via Navigation bar back button
            }
        
        
        // Commented Section below would have automatically added all courses in my courses array into the scrollview (each with their own icon)
        /*
        // Accessable ScrollView Width (not including content outside of screen)
        // let scrollWidth = scrollView.frame.size.width

        for x in 0...courses.count-1 {
            
            /* Creating the button, and image that the button will show. The button is custom type and I declare it as custom type as shown in the code. This means I can customize it as I wish. The Icons are labelled by numbers: Icon1, Icon2, etc... */
            
            let button = UIButton(type: UIButtonType.custom)
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            button.setTitle(courses[x], for: .normal)
            
            // Assigning Identifier to help access buttons
            button.accessibilityIdentifier = String(x)
            
            // setting the image that the button displays.
            button.setImage(image, for: .normal)
            
            // Adding the target action that I manually added to the viewcontroller .swift file (hence the self declaration as the target). I looked up how to input the selector for the @IBAction I made, and the way displayed below is just how you do it. The .touchUpInside is a UIControlEvent; in this case, a touch-up event in the control where the finger is inside the bounds of the control.
            
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            
            // Just filling up the arrays I made earlier. They have no reason for use yet
            images.append(imageView)
            buttons.append(button)
            
            // Setting the x-Position for each of the new buttons added so that they are added outside the current screen
            var newX: CGFloat = 0.0
            
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            
            // Updating the ContentWidth of the UIScrollView for each button so it can hold all the buttons created
            contentWidth += newX
            
            // #imageLiteral(resourceName: "icon1").size.height
            button.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
            // scrollView.addSubview(imageView)
            scrollView.addSubview(button)
            
            // imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        }
         */
        
        // Setting the boolean that lets the created subview (buttons) not be confined to the bounds of the view (I think in this case, the UIScrollView)
        scrollView.clipsToBounds = false
        
        // manually setting the size, specifically the content width of the UIScrollView
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
    
    
    
    // Segue Purposes to ToDoList Screen
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // code
        let ToDoListScene = segue.destination as? CourseNotesViewController
        
        print(buttonPress!)
        
        let indexOfCourseOptional = Int(self.scrollView.subviews[buttonPress!].accessibilityIdentifier!)
        
        let indexOfCourse = indexOfCourseOptional!
        
        ToDoListScene?.CourseTitle = courses[indexOfCourse]
    }
    
    
    
    
    // PickerView Protocol Required Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Hides the Picker View after something is chosen
        PickerViewOutlet.isHidden = true
        PickerViewOutlet.isOpaque = true
        
        /*
         // After the row is selected in the PickerView, bring the buttons back
         for i in 0...scrollView.subviews.count {
         scrollView.subviews[i].isHidden = false
         scrollView.subviews[i].isOpaque = false
         }
         */
        
        // Accessable ScrollView Width (not including content outside of screen)
        let scrollWidth = scrollView.frame.size.width
        
        // Creating the buttons to be added to the ScrollView
        let button = UIButton(type: UIButtonType.custom)
        let image = UIImage(named: "icon\(row).png")
        let imageView = UIImageView(image: image)
        button.setTitle(courses[row], for: .normal)
        
        // Assigning Identifier to help access buttons
        button.accessibilityIdentifier = String(row)
        
        // setting the image that the button displays.
        button.setImage(image, for: .normal)
        
        // Adding the target action that I manually added to the viewcontroller .swift file (hence the self declaration as the target). I looked up how to input the selector for the @IBAction I made, and the way displayed below is just how you do it. The .touchUpInside is a UIControlEvent; in this case, a touch-up event in the control where the finger is inside the bounds of the control.
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
        // Just filling up the arrays I made earlier. I use the second one (buttons) for finding out which buttons I added first
        images.append(imageView)
        buttons.append(button)
        
        // x position of new buttons
        var newX: CGFloat = 0.0
        newX = scrollWidth / 2 + scrollWidth * coursesAdded
        
        // Updating the Number of courses added
        coursesAdded += 1.0
        
        // Updating the ContentWidth of the UIScrollView for each button so it can hold all the buttons created
        contentWidth += newX
        
        // sizing the button to be inserted
        button.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        
        // adding the button to the ScrollView
        scrollView.addSubview(button)
        
        // manually updating the size of the scrollview after new button added
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
        // ScrollView is no longer Empty
        isEmpty = false
        
    }

    
}

