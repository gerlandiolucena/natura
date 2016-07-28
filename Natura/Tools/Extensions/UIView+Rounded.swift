//
//  UIView+Rounded.swift
//  Natura
//
//  Created by Gerlandio on 7/28/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat{
        get {
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        set{
            layer.borderColor = newValue?.CGColor
        }
    }
}
