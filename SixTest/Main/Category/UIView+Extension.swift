//
//  UIView+Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension UIView{
    
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    var width: CGFloat {
        return self.frame.size.width
    }
 
    var height: CGFloat {
        return self.frame.size.height
    }
    var top: CGFloat {
        return self.frame.origin.y
    }
    var bottom: CGFloat {
        return self.frame.maxY
    }
    var left: CGFloat {
        return self.frame.origin.x
    }
    var right: CGFloat {
        return self.frame.maxX
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
    
    
    func addLineSpacing(title:String,lineSize:CGFloat) -> (NSMutableAttributedString) {
        let attStr = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = lineSize
        attStr.addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: NSMakeRange(0, title.characters.count))
        return attStr
    }
    
    func addContentColor(title:String,changeTitle:String,changeTitleColor:UIColor) -> (NSMutableAttributedString) {
        let attStr = NSMutableAttributedString(string: title)
        attStr.addAttributes([NSForegroundColorAttributeName : changeTitleColor], range: NSString(string: title).range(of: changeTitle))
        return attStr
    }
    
    //增加底部线条
    func addBottomLine(color:UIColor,lineHeight:CGFloat) -> () {
        let line = UIView()
        line.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width: frame.size.width, height: lineHeight)
        line.backgroundColor = color
        addSubview(line)
    }
    
    func addTopLine(color:UIColor,lineHeight:CGFloat) -> () {
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: lineHeight)
        line.backgroundColor = color
        addSubview(line)
    }
    
}
