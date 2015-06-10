//
//  MoreView.swift
//  AlertApp
//
//  Created by Barak M on 3/26/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit

class MoreView: UIViewController {

    @IBAction func contactsButton(sender: AnyObject) {
        // Instantiate Contacts Storyboard
        var contactsView = UIStoryboard(name: "Contact", bundle: nil).instantiateInitialViewController() as! UIViewController
        
        self.navigationController?.showViewController(contactsView, sender: self)
    }
    
    @IBAction func policyButton(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        // Set Navigation Tint
        (self.navigationController as? Navigation)?.setTint(UIColor.whiteColor())
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
