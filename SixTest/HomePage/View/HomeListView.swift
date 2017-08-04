//
//  HomeListView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

@objc protocol HomeListViewdelegate : NSObjectProtocol {
    func iconClick(index:NSInteger)
}

class HomeListView: UIView {

    var delegate : HomeListViewdelegate?
    
    // MARK: 懒加载
    lazy var iconView1:HomeListIconView = {
        let iconView = self.addIconView(imageName: "专家心水", title: "专家心水", detail: "免费 超准", tag: 10)
        return iconView
    }()
    
    lazy var iconView2:HomeListIconView = {
        let iconView = self.addIconView(imageName: "人人料", title: "人人料", detail: "分享心水成为专家", tag: 11)
        return iconView
    }()
    
    lazy var iconView3:HomeListIconView = {
        let iconView = self.addIconView(imageName: "心水论坛", title: "心水论坛", detail: "心水分析汇总", tag: 12)
        return iconView
    }()
    
    lazy var iconView4:HomeListIconView = {
        let iconView = self.addIconView(imageName: "查询助手", title: "查询助手", detail: "免费 超准", tag: 13)
        return iconView
    }()
    
    lazy var iconView5:HomeListIconView = {
        let iconView = self.addIconView(imageName: "投票互动", title: "投票互动", detail: "免费 超准", tag: 14)
        return iconView
    }()
    
    lazy var line1:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var line2:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
//    lazy var line3:UIView = {
//        let line = UIView()
//        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
//        return line
//    }()
    
    lazy var line4:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var line5:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var line6:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView1)
        addSubview(iconView2)
        addSubview(iconView3)
        addSubview(iconView4)
        addSubview(iconView5)
        addSubview(line1)
        addSubview(line2)
//        addSubview(line3)
        addSubview(line4)
        addSubview(line5)
        addSubview(line6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconW  = frame.size.width / 2
        let iconH  = frame.size.height / 3
        let lineW:CGFloat  = 0.5
        
        iconView1.frame = CGRect(x: 0, y: 0, width: iconW, height: iconH)
        iconView2.frame = CGRect(x: iconW, y: 0, width: iconW, height: iconH)
        iconView3.frame = CGRect(x: 0, y: iconH, width: iconW, height: iconH)
        iconView4.frame = CGRect(x: iconW, y: iconH, width: iconW, height: iconH)
        iconView5.frame = CGRect(x: 0, y: iconH * 2, width: iconW, height: iconH)
        
        line1.frame = CGRect(x: 0, y: iconH - lineW, width: ScreenWidth, height: lineW)
        line2.frame = CGRect(x: 0, y: iconH * 2 - lineW, width: ScreenWidth, height: lineW)
//        line3.frame = CGRect(x: 0, y: iconH * 3 - lineW, width: ScreenWidth, height: lineW)
        
        
        let iineH = iconH - scaleY(y: 20)
        let lineY = (iconH - iineH) / 2
        line4.frame = CGRect(x: ScreenWidth / 2 - lineW, y: lineY, width: lineW, height: iineH)
        line5.frame = CGRect(x: ScreenWidth / 2 - lineW, y: iconH + lineY, width: lineW, height: iineH)
        line6.frame = CGRect(x: ScreenWidth / 2 - lineW, y: iconH * 2 + lineY, width: lineW, height: iineH)
    }
    
    // MARK: 自定义方法
    func addIconView(imageName:String,title:String,detail:String,tag:NSInteger) -> HomeListIconView {
        let iconView = HomeListIconView()
        iconView.tag = tag
        iconView.refresh(imageName: imageName, title: title, detail: detail)
        let tap = UITapGestureRecognizer(target: self, action: #selector(iconClick))
        iconView.addGestureRecognizer(tap)
        return iconView
    }
    
    // MARK: Target方法
    func iconClick(tap:UITapGestureRecognizer) {
 
        let tag = (tap.view?.tag)! - 10
        delegate?.iconClick(index: tag)
        
    }
    // MARK: HTTP请求
    
}
