//
//  UIButton_iKK.swift
//  iKK_Custom_UIElements
//
//  Created by Stephan Korner on 08.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit

// iKK-Custom: UIButton
//
// The user can set the following under the Attributes Inspector of Main.storyboard :
// - cornerRadius of UIButton (i.e. creates a round button if cornerRadius = half of Width/Heigth)
// - borderWidth of UIButton
// - borderColor of UIButton
// URL: https://www.youtube.com/watch?v=Kd5sJITQ1z4
@IBDesignable
class UIButton_iKK: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /* The answer is Interface Builder. When you drag an object onto a storyboard and configure it, Interface Builder serializes the state of that object on to disk, then deserialize it when the storyboard appears on screen. You need to tell Interface Builder how to do those. At the very least, if you don't add any new properties to your subclass, you can simply ask the superclass to do the packing and unpacking for you, hence the super.init(coder: aDecoder) call. */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
