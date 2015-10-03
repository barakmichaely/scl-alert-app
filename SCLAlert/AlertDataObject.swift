//
//  AlertDataObject.swift
//  SCLAlert
//
//  Created by Barak M on 10/2/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class AlertDataObject: DataObject {

    var userEmail : String = ""
    var mapAddress : String = ""
    var campusName : String = ""
    var buildingName : String = ""
    var specifics : String = ""
    var alertType : String = ""
    
    override var nativeData : NSDictionary {
        get {
            return NSDictionary(dictionary: [
                "userEmail": userEmail,
                "mapAddress": mapAddress,
                "campusName": campusName,
                "buildingName": buildingName,
                "specifics": specifics,
                "alertType": alertType
            ])
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        userEmail = data.valueForKey("userEmail") as! String
        mapAddress = data.valueForKey("mapAddress") as! String
        campusName = data.valueForKey("campusName") as! String
        buildingName = data.valueForKey("buildingName") as! String
        specifics = data.valueForKey("specifics") as! String
        alertType = data.valueForKey("alertType") as! String
    }
}
