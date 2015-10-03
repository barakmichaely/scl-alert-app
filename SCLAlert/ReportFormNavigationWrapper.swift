//
//  ReportFormNavigationWrapper.swift
//  SCLAlert
//
//  Created by Barak M on 10/1/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class ReportFormNavigationWrapper: Navigation {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismiss")
        self.title = "New Report"
        
        print("yeah")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newReportPressed")
        
        // Add Report Form View
        var reportForm = ReportFormController()
        reportForm.modal = true
        viewControllers = [reportForm]
    }
    
    func dismiss () {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
