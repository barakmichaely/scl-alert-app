//
//  ViewController.swift
//  SCLAlert
//
//  Created by Barak M on 6/7/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    override func viewWillAppear(animated: Bool) {
        (self.navigationController as? Navigation)?.setTint(UIColor.blackColor())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
