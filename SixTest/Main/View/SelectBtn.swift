//
//  SelectBtn.swift
//  Swift基本语法
//
//  Created by hxs on 16/10/27.
//  Copyright © 2016年 hxs. All rights reserved.
//


enum btntype {
    case btnTypeImageRight  //图片在右边
    case btnTypeImageTop    //图片在顶边
    case btnTypeImageBottom //图片在底边
}

import UIKit

class SelectBtn: UIButton {
    
    var type:btntype = .btnTypeImageRight
    var margin:CGFloat  = 0

    init(frame: CGRect,name:String) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGray, for: .normal)
        print("重载初始化\(name)")
        
    }
 
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(UIColor.darkGray, for: .normal)
        
        print("初始化")
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //let type2: type = (myType == .btnTypeImageRight) ? .btnTypeImageRight : (myType == .btnTypeImageRight) ? .btnTypeImageTop : .btnTypeImageBottom
        
        guard let imageView = imageView,
              let titleLabel = titleLabel else {
            return
        }
        
        let imageH  = imageView.frame.size.height
        let imageW  = imageView.frame.size.width
        let titleLW = titleLabel.frame.size.width
        let titleLH = titleLabel.frame.size.height
        let width   = frame.width
        
        if type == .btnTypeImageRight{
            
            imageView.frame.origin.x = width - imageW - 5
            titleLabel.frame.origin.x = imageView.frame.origin.x - titleLW - margin
        
        }else if type == .btnTypeImageTop{
            
            imageView.frame =  CGRect(x: (width - imageW)/2, y: 5, width: imageW, height: imageH)
            titleLabel.frame = CGRect(x:( width - titleLW)/2, y: imageView.frame.maxY + margin, width: titleLW, height: titleLH)
            
        }else if type == .btnTypeImageBottom{
            
            imageView.frame =  CGRect(x: (width - imageW)/2, y: frame.size.height - 5 - imageH, width: imageW, height: imageH)
            titleLabel.frame = CGRect(x:( width - titleLW)/2, y: imageView.frame.maxY + margin, width: titleLW, height: titleLH)
            
        }
        
        
        
    }

}
