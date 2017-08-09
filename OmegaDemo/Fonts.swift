//
//  File.swift
//  OmegaDemo
//
//  Created by Administrator on 8/2/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    enum OpenSans: String {
        case extraBoldItalic = "OpenSans-ExtraboldItalic"
        case semiBoldItalic  = "OpenSans-SemiboldItalic"
        case extraBold       = "OpenSans-Extrabold"
        case boldItalic      = "OpenSans-BoldItalic"
        case italic          = "OpenSans-Italic"
        case semiBold        = "OpenSans-Semibold"
        case light           = "OpenSans-Light"
        case regular         = "OpenSans"
        case lightItalic     = "OpenSansLight-Italic"
        case bold            = "OpenSans-Bold"
    }

    static func openSansFont(type: OpenSans, size: CGFloat) -> UIFont {
        return UIFont.init(name: type.rawValue, size: size)!
    }
}
