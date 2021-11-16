//
//  UIColor+Extension.swift
//  Winder
//
//  Created by 이동규 on 2021/11/16.
//

import Foundation
import UIKit

enum WinderColor {
    case pink
    case violet
    case darknavy
}

extension UIColor {
    
  static func getWinderColor(_ name: WinderColor) -> UIColor {
    switch name {
    case .pink:
        return UIColor(displayP3Red: 251/255, green: 163/255, blue: 216/255, alpha: 1.0)
    case .violet:
        return UIColor(displayP3Red: 118/255, green: 57/255, blue: 245/255, alpha: 1.0)
    case .darknavy:
        return UIColor(displayP3Red: 1/255, green: 4/255, blue: 48/255, alpha: 1.0)
    }
  }
    
    //+
}
