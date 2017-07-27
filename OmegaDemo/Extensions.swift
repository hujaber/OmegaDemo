//
//  Extensions.swift
//  OmegaDemo
//
//  Created by Administrator on 7/24/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let oliveColor = colorWithRGB(r: 139, g: 166, b: 57, alpha: 1.0)
    static let lightBlueColor = colorWithRGB(r: 104, g: 202, b: 250, alpha: 1.0)

    private class func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}


extension UIView {
    var borderColor: CGColor {
        get {
            return layer.borderColor!
        }
        set {
            layer.borderColor = newValue
        }
    }

    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
