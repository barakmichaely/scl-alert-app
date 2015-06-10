//
//  Navigation.swift
//  SCLAlert
//
//  Created by Barak M on 6/7/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class Navigation: UINavigationController, UINavigationBarDelegate {
    
    lazy var bar = UINavigationBar()
    let font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        bar = self.navigationBar
//        
//        bar.frame = CGRect(x: -50, y: -100, width: 250, height: 120)
//        
        bar.translucent = true
        bar.barTintColor = UIColor(white: 1, alpha: 0.5)
//        bar.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        bar.tintColor = UIColor.blueColor()
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
//        
//        bar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor()]
//        //bar.frame.origin.y = 100
//        bar.clipsToBounds = false
//        
//        bar.delegate = self
//        
//        self.view.frame.origin.y += 100
        

    }
    
    
    
    func setTint(color:UIColor) {
        // Set Text Color
        bar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : color]
        
        // Set Buttons Tint Color
        bar.tintColor = color
        
        // Reset Status Bar
        setNeedsStatusBarAppearanceUpdate()
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if (bar.tintColor == UIColor.whiteColor()) {
            return UIStatusBarStyle.LightContent
        } else {
            return UIStatusBarStyle.Default
        }
    }
    
    
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
//        return UIBarPosition.Top
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
