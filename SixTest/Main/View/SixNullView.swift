//
//  SixNullView.swift
//  SixTest
//
//  Created by hxs on 2017/8/9.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class SixNullView: UIView {
 
    // MARK: 懒加载
    lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "暂无数据"))
    lazy var messgaeLabel:UILabel = UILabel.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(messgaeLabel)
        
        iconView.contentMode = .center
        iconView.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 30)
        
        messgaeLabel.text = "暂时没有数据哦,去看看其他的吧!"
        messgaeLabel.frame = CGRect(x: 0, y: iconView.bottom, width: ScreenWidth, height: 30)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    //重写frame
    override var frame:CGRect{
        didSet {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

    
}
