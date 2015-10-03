//
//  ReportList.swift
//  SCLAlert
//
//  Created by Barak M on 6/8/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class ReportList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.registerNib(UINib(nibName: "ReportListCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()

        // Setup Navigation Bar
        (self.navigationController! as! Navigation).setTint(UIColor.blueColor())
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newReportPressed")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismiss")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func dismiss () {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func newReportPressed () {
        // Open New Report Form
        openReport()
    }

    func openReport (id : Int = -1, viewOnly : Bool = false) {
        if (id == -1) {
            var reportNavigation = ReportFormNavigationWrapper()
            self.presentViewController(reportNavigation, animated: true, completion: {})
        } else {
            // Create Report Form View
            var reportView = ReportFormController()
            // Set Datasource
            reportView.dataSource = ReportDataObject()
            
            // If it was already sent, disable editing
            if (viewOnly) {
                reportView.viewOnly = true
            }
            
            self.navigationController!.pushViewController(reportView, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Open Reports"
        }
        return "Sent Reports"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewOnly = (indexPath.section == 1) ? true : false
        openReport(indexPath.row, viewOnly: viewOnly)
        //var reportView = self.storyboard!.instantiateViewControllerWithIdentifier("reportView") as! ReportView
        //self.showViewController(reportView, sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Sep. 14th, 2014"
        cell.detailTextLabel?.text = "Verbal Abuse Report"
        
        if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        }

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
