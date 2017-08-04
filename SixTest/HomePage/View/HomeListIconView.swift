//
//  HomeListIconView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HomeListIconView: UIView {

    // MARK: 懒加载
    lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = adoptedFont(fontSize: 15)
        titleLabel.textColor = UIColorFromRGB(rgbValue: kBlackFontColor)
        return titleLabel
    }()
    
    lazy var detailLabel:UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = adoptedFont(fontSize: 12)
        detailLabel.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(detailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = frame.size.height
        let iconWH = scaleX(x: 55)
        iconView.frame = CGRect(x: scaleX(x: 15), y: (height - iconWH) / 2, width: iconWH, height: iconWH)
        titleLabel.frame = CGRect(x: iconView.frame.maxX + scaleX(x: 20), y: scaleY(y: 20), width: scaleX(x: 70), height: scaleY(y: 15))
        detailLabel.frame = CGRect(x: titleLabel.frame.origin.x, y: titleLabel.frame.maxY + scaleY(y: 5), width: scaleX(x: 70), height: scaleY(y: 30))
    }
    
    // MARK: 自定义方法
    func refresh(imageName:String,title:String,detail:String) -> () {
        iconView.image = UIImage(named: imageName)
        titleLabel.text = title
        detailLabel.text = detail
    }
    // MARK: Target方法
    
    // MARK: HTTP请求

}
