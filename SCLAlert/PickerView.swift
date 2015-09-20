//
//  PickerView.swift
//  SCLAlert
//
//  Created by Barak M on 9/20/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class PickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var doneButton : UIButton!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var picker : UIPickerView!
    @IBOutlet var bottomConstraint : NSLayoutConstraint!
    
    var onFinished : ((String?) -> Void)?
    var selection : String?
    
    var selectionOptions : [String] = []
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        picker.delegate = self
        picker.dataSource = self
        
        selection = selectionOptions[0]
        
        doneButton.addTarget(self, action: "doneAction", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: "cancelAction", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didMoveToSuperview() {
        animateIn()
    }
    
    func doneAction () {
        finish()
    }
    
    func cancelAction () {
        selection = nil
        finish()
    }
    
    func finish () {
        onFinished?(selection)
        animateOut()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = selectionOptions[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return selectionOptions[row]
    }
    
    func animateIn () {
        alpha = 0
        bottomConstraint.constant = -300
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 1
            self.bottomConstraint.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    func animateOut () {
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 0
            self.bottomConstraint.constant = -300
            self.layoutIfNeeded()
            }, completion: { b in
                self.removeFromSuperview()
        })
    }


}
