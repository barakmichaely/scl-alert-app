//
//  ReportView.swift
//  AlertApp
//
//  Created by Barak M on 3/26/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit

class ReportView: UIViewController {
    
    var report = NSMutableDictionary()
    var editable = true
    var datePicker:UIDatePicker?
    
    
    @IBOutlet var datetimeButton: UIButton!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var descriptionText: UITextView!
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (editable == false) {
            
            descriptionText.alpha = 0.7
            
            
            descriptionText.userInteractionEnabled = false
            datetimeButton.enabled = false
        }
        
        datetimeButton.addTarget(self, action: "openDatePicker", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton.addTarget(self, action: "sendReport", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.addTarget(self, action: "saveReport", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func openDatePicker() {
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height-200, width: self.view.frame.size.width, height: 200))
        datePicker?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(datePicker!)
        
    }
    
    func sendReport() {
        var text = descriptionText.text
        
        // Create Report Object
        let report = NSMutableDictionary()
        report.setValue("John Dough", forKey: "name")
        report.setValue("06.06.2015", forKey: "date")
        report.setValue("9:45pm", forKey: "time")
        
        if (text == "" || text == " ") {
            text = "I was drunk and some stuff happened. Now I'm pregnant. Help."
        }
        report.setValue(text, forKey: "report")
        
        // Send Report
        APIClient.sendReport(report)
        
        // Close Screen
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveReport() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
