//
//  ReportDataObject.swift
//  SCLAlert
//
//  Created by Barak M on 10/2/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class ReportDataObject: DataObject {

    var userEmail : String = "bm09148n@pace.edu"
    var fullName : String = "John Dough"
    var incidentType : String = "Assault"
    var incidentTime : String = "Evening"
    var incidentDate : String = "Aug. 21st, 2014"
    var incidentLocation : String = "Fulton Dorms"
    var incidentDescription : String = "Someone poked me. With a stick. It left a bruise."
    
    override var nativeData : NSDictionary {
        get {
            return NSDictionary(dictionary: [
                "userEmail": userEmail,
                "fullName": fullName,
                "incidentType": incidentType,
                "incidentTime": incidentTime,
                "incidentDate": incidentDate,
                "incidentLocation": incidentLocation,
                "incidentDescription": incidentDescription
            ])
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        userEmail = data.valueForKey("userEmail") as! String
        fullName = data.valueForKey("fullName") as! String
        incidentType = data.valueForKey("incidentType") as! String
        incidentTime = data.valueForKey("incidentTime") as! String
        incidentDate = data.valueForKey("incidentDate") as! String
        incidentLocation = data.valueForKey("incidentLocation") as! String
        incidentDescription = data.valueForKey("incidentDescription") as! String
    }
    
}
