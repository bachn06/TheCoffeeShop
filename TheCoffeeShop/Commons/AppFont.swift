//
// AppFont.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation
import SwiftUI

enum AppFont {
    static var custom: (Raleway, CGFloat) -> Font = { (weight, size) in
        return Font.custom(weight.weight, size: size)
    }
}

enum Raleway: String {
    case black        = "Raleway-Black"
    case extraBold    = "Raleway-ExtraBold"
    case bold         = "Raleway-Bold"
    case semiBold     = "Raleway-SemiBold"
    case medium       = "Raleway-Medium"
    case regular      = "Raleway-Regular"
    case light        = "Raleway-Light"
    case extraLight   = "Raleway-ExtraLight"
    case thin         = "Raleway-Thin"
    
    var weight: String { return self.rawValue }
}
