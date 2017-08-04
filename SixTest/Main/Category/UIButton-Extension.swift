//
//  UIButton-Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/8/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func addButton(fontSize:CGFloat,textColor:UIColor) -> (UIButton) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.titleLabel?.font = adoptedFont(fontSize: fontSize)
        btn.setTitleColor(textColor, for: UIControlState.normal)
        btn.titleLabel?.textAlignment = .center
        return btn
    }
    
    class func addButton(imageName:String) -> (UIButton) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        return btn
    }
    
}

