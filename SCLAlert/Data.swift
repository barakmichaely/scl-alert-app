//
//  Data.swift
//  SCLAlert
//
//  Created by Barak M on 6/12/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class Data {
    
    init () {
        load()
    }
    
    let filePath : String = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents/data.json")
    
    var contacts:[ContactDataObject] = []
    var openReports:[ReportDataObject] = []
    var sentReports:[ReportDataObject] = []
    
    func save () {
        let data = NSMutableDictionary()
        
        // Must convert to 'NS' data types, to be able to save easily to a file
        let contactsData = NSMutableArray()
        for c in contacts {
            contactsData.addObject(c.nativeData)
        }
        data.setValue(contactsData, forKey: "contacts")
        
        let openReportsData = NSMutableArray()
        for r in openReports {
            openReportsData.addObject(r.nativeData)
        }
        data.setValue(openReportsData, forKey: "openReports")
        
        let sentReportsData = NSMutableArray()
        for r in sentReports {
            sentReportsData.addObject(r.nativeData)
        }
        data.setValue(sentReportsData, forKey: "sentReports")
        
        // Save to a file
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted)
            json.writeToFile(filePath, atomically: true)
        } catch {
            print("Saving Error")
        }
        
        print("finsih saving")
    }
    
    func load () {
        contacts = []
        openReports = []
        sentReports = []
        
        do {
            
            let data = NSData(contentsOfFile: filePath)
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
            
            let contactsData = json.valueForKey("contacts") as! NSArray
            for c in contactsData {
                print(c)
                let newContact = ContactDataObject(data: (c as! NSDictionary))
                contacts.append(newContact)
            }
            
            let openReportsData = json.valueForKey("openReports") as! NSArray
            for r in openReportsData {
                let newOpenReport = ReportDataObject(data: (r as! NSDictionary))
                openReports.append(newOpenReport)
            }
            
            let sentReportsData = json.valueForKey("sentReports") as! NSArray
            for r in sentReportsData {
                let newSentReport = ReportDataObject(data: (r as! NSDictionary))
                sentReports.append(newSentReport)
            }
        } catch {
            print("Loading Error")
        }
        
        print("Finsihed loading")
        print(contacts)
    }
}
