//
//  DatePickerField.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class DatePickerField: Field {

    @IBOutlet var title : UILabel!
    @IBOutlet var selected : UILabel!
    @IBOutlet var button : UIButton!
    
    var selectedDate : String = "" {
        didSet {
            selected.text = selectedDate
        }
    }
    
    func openPicker () {
        let nib = UINib(nibName: "DatePickerView", bundle: nil)
        let picker = nib.instantiateWithOwner(nil, options: nil)[0] as! DatePickerView
        
        parentView.addSubview(picker)
        picker.frame = parentView.frame
        picker.onFinished = { s in
            if (s != nil) {
                self.selectedDate = s!
            }
        }
    }
    
    override func setTitleText (newTitle : String) {
        title.text = newTitle
    }
    
    override func getContent() -> String {
        return selectedDate
    }
    
    override func didMoveToSuperview() {
        button.addTarget(self, action: "openPicker", forControlEvents: UIControlEvents.TouchUpInside)
    }

}
