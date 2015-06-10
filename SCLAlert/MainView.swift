//
//  MainView.swift
//  SCLAlert
//
//  Created by Barak M on 6/7/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet var alertButton: UIButton!
    
    
    @IBAction func reportButton(sender: AnyObject) {
        // Instantiate Report Storyboard
        var reportView = UIStoryboard(name: "Report", bundle: nil).instantiateInitialViewController() as! UIViewController
        
        self.navigationController?.presentViewController(reportView, animated: true, completion: {})
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertButton.addTarget(self, action: "startAlert", forControlEvents: UIControlEvents.TouchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func startAlert() {
        var alertView = UIStoryboard(name: "Alert", bundle: nil).instantiateInitialViewController() as! AlertView
        
        self.presentViewController(alertView, animated: false, completion: {})
    }
    
    override func viewWillAppear(animated: Bool) {
        (self.navigationController as? Navigation)?.setTint(UIColor.blackColor())
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
