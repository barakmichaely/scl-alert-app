//
//  AlertView.swift
//  SCLAlert
//
//  Created by Barak M on 6/9/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class AlertView: UIViewController {

    @IBOutlet var cancelAlertButton: UIButton!
    @IBOutlet var sendAlertButton: UIButton!
    
    @IBOutlet var campusSelection: UIButton!
    @IBOutlet var buildingSelection: UIButton!
    @IBOutlet var specificText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cancelAlertButton.layer.masksToBounds = true
        cancelAlertButton.layer.cornerRadius = 12
        cancelAlertButton.imageView?.image = cancelAlertButton.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cancelAlertButton.addTarget(self, action: "cancelAlert", forControlEvents: UIControlEvents.TouchUpInside)
        
        sendAlertButton.addTarget(self, action: "sendAlert", forControlEvents: UIControlEvents.TouchUpInside)
        
        campusSelection.addTarget(self, action: "selectCampus", forControlEvents: UIControlEvents.TouchUpInside)
        buildingSelection.addTarget(self, action: "selectBuilding", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func selectCampus() {
        var picker = self.storyboard!.instantiateViewControllerWithIdentifier("Picker") as! AlertPicker!
        
        picker.selected = self.campusSelection.titleLabel!.text!
        picker.data = ["New York City","Pleasantville","White Plains","*Off Campus*"]
        
        picker.done = { selected in
            self.campusSelection.titleLabel?.text = selected as String
            picker.view.removeFromSuperview()
            picker.removeFromParentViewController()

        }
        self.addChildViewController(picker)
        self.view.addSubview(picker.view)
    }

    func selectBuilding() {
        var picker = self.storyboard!.instantiateViewControllerWithIdentifier("Picker") as! AlertPicker!
        
        picker.selected = self.buildingSelection.titleLabel!.text!
        picker.data = ["Maria's Tower","John St. Dorms","Fulton St. Dorms","Other"]
        
        picker.done = { selected in
            self.buildingSelection.titleLabel?.text = selected as String
            picker.view.removeFromSuperview()
            picker.removeFromParentViewController()
            
        }
        self.addChildViewController(picker)
        self.view.addSubview(picker.view)
    }
    
    
    func cancelAlert() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func sendAlert() {
        // Create Alert Object
        var alert = NSMutableDictionary()
        alert.setValue("John Dough", forKey: "name")
        alert.setValue("40.7134519,-74.003797", forKey: "location")
        alert.setValue("06.07.2015", forKey: "date")
        alert.setValue("9:45pm", forKey: "time")
        //alert.setValue(["2126661234"], forKey: "contacts")
        
        // Send Alert
        APIClient.sendAlert(alert)
        
        // Close Screen
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
