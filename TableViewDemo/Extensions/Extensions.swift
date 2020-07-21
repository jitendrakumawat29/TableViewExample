//
//  Extensions.swift
//  TableViewDemo
//
//  Created by Jitendra Kumar on 21/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    public class var appThemeColor: UIColor
    {
        return UIColor(red: 36.0/255.0, green: 92.0/255.0, blue: 191.0/255.0, alpha: 1)
    }
}

extension UIFont {
   
    static public func regular(_ size:CGFloat = 16) -> UIFont {
        return UIFont.init(name: "Roboto-Regular", size: size)!
    }
    static public func bold(_ size:CGFloat = 16) -> UIFont {
        return UIFont.init(name: "Roboto-Bold", size: size)!
    }
    static public func semiBold(_ size:CGFloat = 16) -> UIFont {
        return UIFont.init(name: "Roboto-SemiBold", size: size)!
    }
    static public func Medium(_ size:CGFloat = 16) -> UIFont {
        return UIFont.init(name: "Roboto-Medium", size: size)!
    }
}
