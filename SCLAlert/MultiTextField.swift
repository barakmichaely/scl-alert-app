//
//  MultiTextField.swift
//  SCLAlert
//
//  Created by Barak M on 9/17/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class MultiTextField: Field, UITextViewDelegate {

    @IBOutlet var title : UILabel!
    @IBOutlet var textbox : UITextView!
    
    override func setTitleText (newTitle : String) {
        title.text = newTitle
    }
    
    override func getContent () -> String {
        return textbox.text
    }
    
    override func disable() {
        textbox.editable = false
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        textbox.scrollEnabled = false
        textbox.delegate = self
        //
        
    }
    
    func textViewDidChange(textView: UITextView) {
        let fixedWidth = textbox.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = textbox.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textbox.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        // Animate textbox resizing. *For style points
        UIView.animateWithDuration(0.2, animations: {
            self.textbox.frame = newFrame
            }, completion: { boolean in
                self.resized?()
        })

    }

}
