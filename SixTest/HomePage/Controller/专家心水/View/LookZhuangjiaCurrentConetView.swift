//
//  LookZhuangjiaCurrentConetView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/22.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LookZhuangjiaCurrentConetView: UIView {

    var nextPublishDateNo:String? {
        didSet{
            dateNoLabel.text = "    \(nextPublishDateNo ?? "")"
        }
    }
    
    // MARK: didSet
    var currentModel:ZhuangjiaCurrentHistoryModel? {
        didSet{
            dateNoLabel.text = "    \(nextPublishDateNo ?? "")"
            titleLabel.text = currentModel?.title
            
            ballsView.dataArr = currentModel?.data?.components(separatedBy: ",") ?? []
        }
    }
    
    // MARK: 懒加载
    lazy var dateNoLabel:UILabel = {
        let label = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()
    
    lazy var titleLabel:UILabel = {
        let label = self.addLabel(fontSize: 19, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    lazy var ballsView:BallsView = {
        let ballsView = BallsView()
        return ballsView
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateNoLabel)
        addSubview(titleLabel)
        addSubview(ballsView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateNoLabel.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 25))
        dateNoLabel.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        dateNoLabel.addTopLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        
        titleLabel.frame = CGRect(x: 0, y: dateNoLabel.bottom + scaleY(y: 15), width: ScreenWidth, height: scaleY(y: 20))
        
        ballsView.frame = CGRect(x: 0, y: titleLabel.bottom, width: ScreenWidth, height: ScreenHeight - titleLabel.bottom)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
