//
//  SingleTextField.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class SingleTextField: Field {

    @IBOutlet var title : UILabel!
    @IBOutlet var textbox : UITextField!
    
    
    override func setTitleText (newTitle : String) {
        title.text = newTitle
    }
    
    override func getContent () -> String {
        return textbox.text
    }
    
    override func disable() {
        textbox.enabled = false
    }
    
}