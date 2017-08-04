//
//  NSMutableAttributedString+Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    
    func addLineSpacing(title:String,lineSize:CGFloat) -> () {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = lineSize
        addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: NSMakeRange(0, title.characters.count))
    }
    
    func addContentColor(title:String,changeTitle:String,changeTitleColor:UIColor) -> () {
        
        addAttributes([NSForegroundColorAttributeName : changeTitleColor], range: NSString(string: title).range(of: changeTitle))
    }
    
    class func itemWithTarget(target:Any,action:Selector,image:String,highImage:String) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setBackgroundImage(UIImage(named: image), for: .normal)
        btn.setBackgroundImage(UIImage(named: highImage), for: .selected)
        btn.frame.size = (btn.currentImage?.size)!
        return UIBarButtonItem(customView: btn)
    }
    
    class func itemWithTarget(target:Any,action:Selector,title:String,titleColor:UIColor) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: scaleX(x: 60), height: scaleX(x: 40))
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
}

