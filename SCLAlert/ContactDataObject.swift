//
//  ContactDataObject.swift
//  SCLAlert
//
//  Created by Barak M on 10/2/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class ContactDataObject: DataObject {

    var name : String = ""
    var phone : String = ""
    var email : String = ""
    
    override var nativeData : NSDictionary {
        get {
            return NSDictionary(dictionary: ["name": name, "phone": phone, "email": email])
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        name = data.valueForKey("name") as! String
        phone = data.valueForKey("phone") as! String
        email = data.valueForKey("email") as! String
    }
    
}
