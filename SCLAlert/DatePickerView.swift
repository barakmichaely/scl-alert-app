//
//  DatePickerView.swift
//  SCLAlert
//
//  Created by Barak M on 9/20/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    @IBOutlet var doneButton : UIButton!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var picker : UIDatePicker!
    
    var onFinished : ((String?) -> Void)?
    var selection : String?
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        doneButton.addTarget(self, action: "doneAction", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: "finish", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func doneAction () {
        var newDate = ""
        let dateFormat = NSDateFormatter()
        
        dateFormat.dateFormat = "MMMM d, yyyy"
        newDate = dateFormat.stringFromDate(picker.date)
        
        selection = newDate
        finish()
    }
    
    func finish () {
        onFinished?(selection)
        self.removeFromSuperview()
    }
    
}
