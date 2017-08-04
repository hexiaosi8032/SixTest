//
//  DataYypeCell.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class DataYypeCell: UICollectionViewCell {
    
    var model:DataTypeModel? {
        didSet{
            titleLabel.text = model?.name
        }
    }
    
    // MARK: 懒加载
    lazy var titleLabel:UILabel = UILabel.addLabel(fontSize: 15, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    
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
        
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColorFromRGB(rgbValue: kLineColor).cgColor
        
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: ScreenWidth / 2, height: frame.size.height)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
    

}
