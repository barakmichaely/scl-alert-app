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
    
    override func viewDidLoad() {
        super.viewDidLoad() 

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
