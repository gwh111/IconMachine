//
//  SW_Share.swift
//  testSwiftOC
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

import Foundation
import AppKit
import SwiftUI

// MARK:ui
//func W() -> CGFloat {
//    return CGFloat(ccs.width())
//}
//
//func H() -> CGFloat {
//    return CGFloat(ccs.height())
//}

func RH(_ height:CGFloat) -> CGFloat {
    return height
}

func RF(_ fontSize:CGFloat) -> NSFont {
    return NSFont.systemFont(ofSize: fontSize)
}

//func BRF(_ fontSize:CGFloat) -> NSFont {
//    return NSFont.boldSystemFont(ofSize: fontSize)
//}

// MARK:color
func COLOR_WHITE() -> NSColor {
    return NSColor.white
}

func COLOR_BLACK() -> NSColor {
    return NSColor.black
}

func COLOR_CLEAR() -> NSColor {
    return NSColor.clear
}

func RGB(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> NSColor {
    return NSColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ alpha:CGFloat) -> NSColor {
    return NSColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

func Language(_ t1:String,_ t2:String) -> String {
    return La.text(t1, t2)
}
