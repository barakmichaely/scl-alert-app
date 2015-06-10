//
//  AlertView.swift
//  SCLAlert
//
//  Created by Barak M on 6/9/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class AlertView: UIViewController {

    @IBOutlet var cancelAlertButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cancelAlertButton.layer.masksToBounds = true
        cancelAlertButton.layer.cornerRadius = 12
        cancelAlertButton.imageView?.image = cancelAlertButton.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cancelAlertButton.addTarget(self, action: "cancelAlert", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func cancelAlert() {
        self.dismissViewControllerAnimated(false, completion: {})
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
