//
//  HomeTimeShowView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HomeTimeShowView: UIView {

    // MARK: 懒加载
    lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.font = adoptedFont(fontSize: 12)
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        return label
    }()
    
    lazy var zhiboLabel:UILabel = {
        let label = UILabel()
        label.font = adoptedFont(fontSize: 12)
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        return label
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(timeLabel)
        addSubview(zhiboLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = frame.size.height
        let widht  = frame.size.width
        timeLabel.frame  = CGRect(x: scaleX(x: 15), y: 0, width: scaleX(x: 170), height: height)
        zhiboLabel.frame = CGRect(x:widht - scaleX(x: 140) , y: 0, width: scaleX(x: 130), height: height)
    }
    // MARK: 自定义方法
    
    // MARK: Target方法
    
    // MARK: HTTP请求

}
