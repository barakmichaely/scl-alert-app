//
//  EditContact.swift
//  SCLAlert
//
//  Created by Barak M on 6/8/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class EditContact: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var number: UITextField!
    
    var contactPos = 0
    var contact = ContactDataObject()
    var editButton:UIBarButtonItem!
    
    var editingText = false {
        didSet{
            if (editingText) {
                self.editButton.title = "Done"
            } else {
                self.editButton.title = "Edit"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Done, target: self, action: "toggleEdit")
        self.navigationItem.rightBarButtonItem = editButton

        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "unfocus"))
        
        name.addTarget(self, action: "startedNameEdit", forControlEvents: UIControlEvents.EditingDidBegin)
        name.addTarget(self, action: "endedNameEdit", forControlEvents: UIControlEvents.EditingDidEnd)
        
        number.addTarget(self, action: "startedNumberEdit", forControlEvents: UIControlEvents.EditingDidBegin)
        number.addTarget(self, action: "endedNumberEdit", forControlEvents: UIControlEvents.EditingDidEnd)
        
        name.delegate = self
        number.delegate = self
        
        updateInfo()

        // Do any additional setup after loading the view.
    }
    
    func toggleEdit() {
        editingText = !editingText
        if (editingText) {
            name.becomeFirstResponder()
        } else {
            name.resignFirstResponder()
            number.resignFirstResponder()
        }
    }
    
    func unfocus() {
        self.name.resignFirstResponder()
        self.number.resignFirstResponder()
        editingText = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Save Information
        contact.name = name.text!
        contact.phone = number.text!
        
        data.contacts[contactPos] = contact
        
        // Remove Empty Contact
        if (name.text == "" || number.text == "") {
            data.contacts.removeAtIndex(contactPos)
        }
        
        data.save()
    }
    
    func updateInfo() {
        contact = data.contacts[contactPos]
        name.text = contact.name
        number.text = contact.phone
        
//        if let cName = contact.valueForKey("name") as? String {
//            name.text = cName
//        } else {
//            name.text = ""
//        }
//        if let cNumber = contact.valueForKey("number") as? String {
//            number.text = cNumber
//        } else {
//            number.text = ""
//        }
        
        if (name.text == "") {
            editingText = true
            name.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (name.isFirstResponder()) {
            number.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()            
            editingText = false
        }
        return true
    }
    

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.keyboardType == UIKeyboardType.NamePhonePad) {
            var newString = (textField.text as! NSString).stringByReplacingCharactersInRange(range, withString: string)
            var components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            var decimalString = components.joinWithSeparator("") as NSString
            var length = decimalString.length
            var hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                var newLength = (textField.text as! NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            var formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.appendString("1 ")
                index += 1
            }
            if (length - index) > 3 {
                var areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            if length - index > 3 {
                var prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            var remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            return false
        } else {
            return true
        }
    }


    func startedNameEdit() {
        print("start")
        name.borderStyle = UITextBorderStyle.RoundedRect
        name.backgroundColor = UIColor(white: 1, alpha: 0.2)
        editingText = true
    }
    
    func endedNameEdit() {
        print("end")
        name.borderStyle = UITextBorderStyle.None
        name.backgroundColor = UIColor.clearColor()
    }
    
    func startedNumberEdit() {
        print("start")
        number.borderStyle = UITextBorderStyle.RoundedRect
        number.backgroundColor = UIColor(white: 1, alpha: 0.2)
        editingText = true
    }
    
    func endedNumberEdit() {
        print("end")
        number.borderStyle = UITextBorderStyle.None
        number.backgroundColor = UIColor.clearColor()
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
