//
//  UIBarButtonItem+Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func itemWithTarget(target:Any,action:Selector,image:String,highImage:String) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: highImage), for: .selected)
        btn.frame = CGRect(x: 0, y: 0, width: (btn.currentImage?.size.width)!, height: (btn.currentImage?.size.height)!)
//        btn.frame = CGRect(x: 0, y: 0, width: (btn.currentImage?.size.width)! * 2, height: (btn.currentImage?.size.height)! * 2)
        return UIBarButtonItem(customView: btn)
    }
    
    class func itemWithTarget(target:Any,action:Selector,title:String,titleColor:UIColor) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = adoptedFont(fontSize: 15)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
}
