//
//  TypesColor.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 03/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
import UIKit

func getColorFromType(type: Int) -> UIColor {
    switch type {
    case 1:
        return UIColor(red:0.21, green:0.19, blue:0.18, alpha:1.0)
    case 2:
        return UIColor(red:0.79, green:0.27, blue:0.06, alpha:1.0)
    case 3:
        return UIColor(red:0.67, green:0.72, blue:0.94, alpha:1.0)
    case 4:
        return UIColor(red:0.31, green:0.00, blue:0.00, alpha:1.0)
    case 5:
        return UIColor(red:0.96, green:0.04, blue:0.07, alpha:1.0)
    case 7:
        return UIColor(red:0.20, green:0.65, blue:0.16, alpha:1.0)
    case 8:
        return UIColor(red:0.58, green:0.58, blue:0.58, alpha:1.0)
    case 9:
        return UIColor(red:0.47, green:0.28, blue:0.42, alpha:1.0)
    case 10:
        return UIColor(red:0.98, green:1.00, blue:0.31, alpha:1.0)
    case 11:
        return UIColor(red:0.24, green:0.22, blue:0.07, alpha:1.0)
    case 12:
        return UIColor(red:0.46, green:0.05, blue:0.98, alpha:1.0)
    case 13:
        return UIColor(red:0.04, green:0.48, blue:0.43, alpha:1.0)
    case 14:
        return UIColor(red:0.41, green:0.40, blue:0.24, alpha:1.0)
    case 15:
        return UIColor(red:0.15, green:0.78, blue:0.94, alpha:1.0)
    default:
        return UIColor.black
    }
}
