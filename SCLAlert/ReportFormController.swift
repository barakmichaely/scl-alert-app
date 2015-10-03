//
//  ReportFormController.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class ReportFormController: UIViewController {

    // Fields Array Structure: type, title, array of selection options (for dropdowns and such)
    var fields : Array<(String,String,Array<String>)> = [
        ("SingleTextField","1. YOUR FULL NAME",[]),
        ("DatePickerField","2. DATE OF INCIDENT",[]),
        ("DropdownField","3. TIME OF INCIDENT",["Morning","Afternoon","Evening","Night","Late Night"]),
        ("DropdownField","4. TYPE OF INCIDENT",["Assault","Harrassment","Cyber Abuse"]),
        ("SingleTextField","5. WHERE DID IT HAPPEN?",[]),
        ("MultiTextField","6. FULL DESCRIPTION",[])
    ]
    
    var fieldViews : Array<Field> = []
    var scroller : UIScrollView!
    
    var dataSource : ReportDataObject = ReportDataObject()
    
    var viewOnly = false
    var modal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Items
            // Add Cancel Button if View was presented as a Modal Popup
        if (modal) {
            self.navigationItem.title = "New Report"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismiss")
        } else {
            if (viewOnly) {
                self.navigationItem.title = "Sent Report (View Only)"
            } else {
                self.navigationItem.title = "Open Report"
            }
        }
        
        // Set Styles
        view.backgroundColor = UIColor.whiteColor()
        
        // Create Scrollable Form
        createFields()
        setConstraints()
        resizeScroll()
        
        // Create Buttons
        if (!viewOnly) {
            createButtons()
        }
        
        scroller.layoutIfNeeded()
    }
    
    func dismiss () {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func createButtons () {
        var submit = UIButton(frame: CGRect(x: 20, y: self.view.frame.height - 70 - 64, width: (self.view.frame.width/2) - 40, height: 60))
        var save = UIButton(frame: CGRect(x: (self.view.frame.width/2) + 20, y: self.view.frame.height - 70 - 64, width: (self.view.frame.width/2) - 40, height: 60))
        var bar = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 80 - 64, width: self.view.frame.width, height: 80))
        
        // Set Button Design
        submit.backgroundColor = UIColor.blueColor()
        save.backgroundColor = UIColor.greenColor()
        
        submit.setTitle("Submit", forState: UIControlState.Normal)
        save.setTitle("Save", forState: UIControlState.Normal)
        
        submit.titleLabel!.textColor = UIColor.whiteColor()
        save.titleLabel!.textColor = UIColor.whiteColor()
        
        bar.backgroundColor = UIColor(white: 1, alpha: 0.85)
        
        // Set Button Actions
        submit.addTarget(self, action: "submitPressed", forControlEvents: UIControlEvents.TouchUpInside)
        save.addTarget(self, action: "savePressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add Buttons to View
        self.view.addSubview(bar)
        self.view.addSubview(submit)
        self.view.addSubview(save)
    }
    
    func submitPressed () {
        print("Submit")
    }
    func savePressed () {
        print("save")
    }
    
    func createFields () {
        // Create Scrollview
        scroller = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scroller)
        
        // Create Fields
        for i in 0..<fields.count {
            let f = fields[i]
            let nib = UINib(nibName: f.0, bundle: nil)
            let field = nib.instantiateWithOwner(nil, options: nil)[0] as! Field
            
            if (self.viewOnly) {
                field.disable()
            }
            field.resized = {
                self.resizeScroll()
            }
            field.parentView = self.navigationController!.view
            field.setTitleText(f.1)
            field.setOptions(f.2)
            field.translatesAutoresizingMaskIntoConstraints = false
            
            scroller.addSubview(field)
            
            let widthConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: field.superview, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
            
            let heightConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 50)
            
            let horizontalConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: field.superview, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            
//            if (i != 0) {
//                let ypos : CGFloat = (CGFloat(i)) * 85.0
//                let topConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: field.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: ypos )
//                scroller.addConstraint(topConstraint)
//            }
            
            scroller.addConstraints([widthConstraint,heightConstraint,horizontalConstraint])
            fieldViews.append(field)
            
        }
    }
    
    func resizeScroll () {
        var contentRect = CGRect.zero
        for view in self.scroller.subviews {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
        self.scroller.contentSize = CGSize(width: self.view.frame.width, height: contentRect.height + 126)
    }
    
    func setConstraints () {
        var lastField : Field?
        
        for field in fieldViews {
            if (lastField != nil) {
                let topConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0 )
                scroller.addConstraint(topConstraint)
            } else {
                let staticTopConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scroller, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0 )
                scroller.addConstraint(staticTopConstraint)
            }
            lastField = field
        }
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
