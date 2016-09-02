//
//  NJMacro.swift
//  NJToDo
//
//  Created by Nugget Jiang on 15/12/21.
//  Copyright © 2015年 Nugget Jiang. All rights reserved.
//

import Foundation
import UIKit

let UIScreenWidth = UIScreen.mainScreen().bounds.size.width
let UIScreenHeight = UIScreen.mainScreen().bounds.size.height

let TabBarHeight:CGFloat = 50.0
let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

let NKVersion = 52

let iOS6:Bool = (Float(UIDevice.currentDevice().systemVersion)! - 6.0 >= 0 ? true:false)
let iOS7:Bool = (Float(UIDevice.currentDevice().systemVersion)! - 7.0 >= 0 ? true:false)
let iOS8:Bool = (Float(UIDevice.currentDevice().systemVersion)! - 8.0 >= 0 ? true:false)
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }
func RGB (r:CGFloat, g:CGFloat, b:CGFloat)->UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0) }




