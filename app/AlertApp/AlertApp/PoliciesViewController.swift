//
//  PoliciesViewController.swift
//  AlertApp
//
//  Created by Tanya Sahin on 4/15/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit

class PoliciesViewController: UIViewController {
    
    @IBOutlet weak var policiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let policySummary = defaults.stringForKey("Policy Summary") {
            self.policiesLabel.text = policySummary //Policy Summary already stored
            println("printed saved policy summary")
            
        } else {
        
            let url = NSURL(string: "http://sclapp.herokuapp.com/info")

            let request = NSURLRequest(URL: url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                
                if (error != nil) {
                    println(error)
                } else if (data != nil && response != nil) { //need to check both?
                
                    var parseData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary //TODO: have to verify all these as! (also the following ones)
                    
                    println(parseData)
                    
                    var info = parseData.valueForKey("Information") as! NSDictionary
                    var policies = info.valueForKey("Policies") as! NSArray
                    var polSummary = policies[1].valueForKey("Policy Summary") as! NSString
                    
                    self.policiesLabel.text = polSummary as String
                    
                    defaults.setObject(polSummary, forKey: "Policy Summary")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    
}


