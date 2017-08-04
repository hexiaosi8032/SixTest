//
//  HotDataCell.swift
//  SixTest
//
//  Created by IMAC on 2017/7/28.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HotDataCell: UICollectionViewCell {
    
    var model:HotDataModel? {
        didSet{
            titleLabel.text = model?.title
            hotWarnLabel.text = "当前热度"
            hotLabel.text = model?.hits
        }
    }
    
    // MARK: 懒加载
    lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "火"))
    lazy var titleLabel:UILabel = UILabel.addLabel(fontSize: 15, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    lazy var hotWarnLabel:UILabel = UILabel.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    lazy var hotLabel:UILabel = UILabel.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kMainThemeColor))
    lazy var line:UIView = UIView()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(hotWarnLabel)
        contentView.addSubview(hotLabel)
        contentView.addSubview(line)
        titleLabel.textAlignment = .left
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        
        iconView.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 15), width: scaleX(x: 18), height: scaleY(y: 15))
        titleLabel.frame = CGRect(x: iconView.right + scaleX(x: 5), y: scaleY(y: 15), width: scaleX(x: 245), height: scaleY(y: 15))
        hotWarnLabel.frame = CGRect(x: titleLabel.right + scaleX(x: 30), y: scaleY(y: 10), width: scaleX(x: 50), height: scaleY(y: 12))
        hotLabel.frame = CGRect(x: titleLabel.right + scaleX(x: 30), y: hotWarnLabel.bottom + scaleY(y: 5), width: scaleX(x: 50), height: scaleY(y: 12))
        line.frame = CGRect(x: 0, y: frame.size.height - 0.5, width: ScreenWidth, height: 0.5)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
