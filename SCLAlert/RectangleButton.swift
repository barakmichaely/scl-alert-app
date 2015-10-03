//
//  RectangleButton.swift
//  SCLAlert
//
//  Created by Barak M on 10/2/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class RectangleButton: UIButton {

    func redesign () {
        let imageOffsetX = (imageView == nil) ? 0 : imageView!.frame.width
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 1
        titleEdgeInsets = UIEdgeInsetsMake(0,  -imageOffsetX, 0, 0)
        imageEdgeInsets = UIEdgeInsetsMake(0, frame.width - imageOffsetX, 0, 0)
        backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redesign()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
