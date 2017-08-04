//
//  UILabel-Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/7/28.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension UILabel{
    
    class func addLabel(fontSize:CGFloat,textColor:UIColor) -> (UILabel) {
        let label = UILabel()
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .center
        label.textColor = textColor
        return label
    }
}
