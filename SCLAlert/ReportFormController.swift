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
    
    var disabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFields()
        setConstraints()
        resizeScroll()
        scroller.layoutIfNeeded()

        // Do any additional setup after loading the view.
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
            
            if (self.disabled) {
                field.disable()
            }
            field.resized = {
                self.resizeScroll()
            }
            field.parentView = self.view
            field.setTitleText(f.1)
            field.setOptions(f.2)
            field.setTranslatesAutoresizingMaskIntoConstraints(false)
            
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
        var contentRect = CGRect.zeroRect
        for view in self.scroller.subviews {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
        self.scroller.contentSize = CGSize(width: self.view.frame.width, height: contentRect.height + 60)
    }
    
    func setConstraints () {
        var lastField : Field?
        
        for field in fieldViews {
            if (lastField != nil) {
                var topConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0 )
                scroller.addConstraint(topConstraint)
            } else {
                var staticTopConstraint = NSLayoutConstraint(item: field, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scroller, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0 )
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
