//
//  ReportTabController.swift
//  SCLAlert
//
//  Created by Barak M on 6/8/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class ReportTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.tabBar.translucent = false
        
        self.tabBar.shadowImage = UIImage()
        self.tabBar.barStyle = UIBarStyle.Default
        self.tabBar.backgroundColor = UIColor.clearColor()
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor(red: 0.102, green: 0.586, blue: 0.489, alpha: 1)
        
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], forState: UIControlState.Normal)
        
        
        
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
