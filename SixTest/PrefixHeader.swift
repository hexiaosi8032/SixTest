//
//  PrefixHeader.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

//import Foundation
import UIKit
/*
 // MARK: 懒加载
 
 // MARK: 初始化和生命周期
 override func viewDidLoad() {
 super.viewDidLoad()
 
 setupUI()
 }
 
 // MARK: 自定义方法
 func setupUI() -> () {
 title = ""
 view.backgroundColor = UIColor.white
 automaticallyAdjustsScrollViewInsets = false
 
 }
 
 // MARK: Target方法
 
 // MARK: HTTP请求
 
 // MARK: 代理和协议
 
 */

let ScreenWidth   = UIScreen.main.bounds.size.width
let ScreenHeight  = UIScreen.main.bounds.size.height

let NavBarHeight:CGFloat = 64
let TabBarHeight:CGFloat = 49

func scaleX(x:CGFloat) -> CGFloat {
    
    let sizeWidthScale = ScreenWidth / 375
    
    return x * sizeWidthScale
}

func scaleY(y:CGFloat) -> CGFloat {
    
    let sizeHeightScale = ScreenHeight / 667
    
    return y * sizeHeightScale
    
}
 
func UIColorFromRGB(rgbValue:Int) -> UIColor {
    
    let r = (rgbValue >> 16) & 0xFF;
    let g = (rgbValue >> 8) & 0xFF;
    let b = (rgbValue) & 0xFF;
    
    return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
}

func adoptedFont(fontSize:CGFloat) -> UIFont {
    let sizeWidthScale = ScreenWidth / 375
    return UIFont.systemFont(ofSize: fontSize * sizeWidthScale)
}



