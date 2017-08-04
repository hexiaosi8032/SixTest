//
//  SixNavLabel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class SixNavLabel: UILabel {

    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    init(topTitle:String,bottomTitle:String) {
        let rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 64)
        super.init(frame: rect)
        
        textColor = UIColor.white
        textAlignment = .center
        numberOfLines = 0
        text = "\(topTitle)\n\(bottomTitle)"
        
        let attStr = NSMutableAttributedString.init(string: text ?? "")
        attStr.addAttributes([NSFontAttributeName : adoptedFont(fontSize: 18)], range:  NSString(string: text ?? "").range(of: topTitle))
        attStr.addAttributes([NSFontAttributeName : adoptedFont(fontSize: 12)], range:  NSString(string: text ?? "").range(of: bottomTitle))
        attributedText = attStr
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重写frame
    override var frame:CGRect{
        didSet {
            
        }
    }
    
    // MARK: 自定义方法
  
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
