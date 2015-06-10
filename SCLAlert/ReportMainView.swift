//
//  ReportMainView.swift
//  SCLAlert
//
//  Created by Barak M on 6/7/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class ReportMainView: UIViewController {
    
    @IBOutlet var segmentContoller: UISegmentedControl!
    
    @IBOutlet var container: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add x Button to Navigation
        var xImage = UIImage(named: "cancelx16.png")
        var dismissButton = UIBarButtonItem(image: xImage, style: UIBarButtonItemStyle.Done, target: self, action: "dismiss")
        self.navigationItem.leftBarButtonItem = dismissButton
        
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewWillAppear(animated: Bool) {
        (self.navigationController as? Navigation)?.setTint(UIColor.whiteColor())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //segue.destinationViewController = UIViewController()
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
