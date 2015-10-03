//
//  CircleButton.swift
//  SCLAlert
//
//  Created by Barak M on 10/2/15.
//  Copyright © 2015 Barak M. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    func redesign () {
        let titleOffsetX = (imageView == nil) ? 0 : -imageView!.frame.width
        layer.cornerRadius = frame.width/2
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 1
        imageEdgeInsets = UIEdgeInsetsMake(0, (frame.width/2) + (titleOffsetX/2), 0, 0)
        backgroundColor = UIColor.whiteColor()
        titleEdgeInsets = UIEdgeInsetsMake((frame.height) + 50, titleOffsetX, 0, 0)
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
