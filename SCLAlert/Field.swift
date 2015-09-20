//
//  Field.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class Field: UIView {

    var loaded : (() -> Void)?
    
    var resized : (() -> Void)?
    
    var parentView : UIView!    
    
    func setTitleText (newTitle : String) {}

    func setOptions (options : Array<String>) {}
    
    func setSelectedOption (selected : String) {}
    
    func getContent () -> String { return "" }
    
    func checkValid () -> Bool { return true }
    
    func disable () { }
    
    override func didMoveToSuperview() {
        loaded?()
    }

}
