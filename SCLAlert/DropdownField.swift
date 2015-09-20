//
//  DropdownField.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class DropdownField: Field {

    @IBOutlet var title : UILabel!
    @IBOutlet var selected : UILabel!
    @IBOutlet var button : UIButton!
    
    
    var selectionOpts : Array<String> = [] {
        didSet {
            if (selectionOpts.count > 0) {
                selectedOpt = selectionOpts[0]
            } else {
                selectedOpt = "Choose an Option"
            }
        }
    }
    var selectedOpt = "Default Option" {
        didSet {
            selected.text = selectedOpt
        }
    }
    
    func openPicker () {
        let nib = UINib(nibName: "PickerView", bundle: nil)
        let picker = nib.instantiateWithOwner(nil, options: nil)[0] as! PickerView
        
        picker.selectionOptions = selectionOpts
        
        parentView.addSubview(picker)
        picker.frame = parentView.frame
        picker.onFinished = { s in
            if (s != nil) {
                self.selectedOpt = s!
            }
        }
        
    }
    
    override func setTitleText (newTitle : String) {
        title.text = newTitle
    }
    
    override func setOptions(options: Array<String>) {
        selectionOpts = options
    }
    
    override func getContent () -> String {
        return selectedOpt
    }
    
    override func didMoveToSuperview() {
        button.addTarget(self, action: "openPicker", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    

}
