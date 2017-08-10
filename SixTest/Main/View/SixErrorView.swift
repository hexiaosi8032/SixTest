//
//  SixErrorView.swift
//  SixTest
//
//  Created by hxs on 2017/8/9.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class SixErrorView: UIView {
    
    // MARK: 懒加载
    var myBlock:(() -> Void)?
    
    lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "加载失败"))
    lazy var messageLabel:UILabel = UILabel.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    
    // MARK: 初始化和生命周期
    init(frame: CGRect,block:@escaping (() -> Void)){
        super.init(frame: frame)
        
        myBlock = block
        
        backgroundColor = UIColor.white
        isUserInteractionEnabled = true
        
        addSubview(iconView)
        addSubview(messageLabel)
        iconView.contentMode = .center
        
        iconView.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 20)
        messageLabel.frame = CGRect(x: 0, y: iconView.bottom, width: frame.size.width, height: 70)
        
        let message = "网络不好,加载失败\n点击屏幕重新加载"
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        let attStr = NSMutableAttributedString(string: message)
        attStr.addAttributes([NSForegroundColorAttributeName : UIColorFromRGB(rgbValue: kBlackFontColor)], range: NSString(string: message).range(of: "网络不好,加载失败"))
        attStr.addAttributes([NSForegroundColorAttributeName : UIColorFromRGB(rgbValue: kLightGrayFontColor)], range: NSString(string: message).range(of: "点击屏幕重新加载"))
        attStr.addAttributes([NSFontAttributeName : adoptedFont(fontSize: 15)], range: NSString(string: message).range(of: "网络不好,加载失败"))
        attStr.addAttributes([NSFontAttributeName : adoptedFont(fontSize: 12)], range: NSString(string: message).range(of: "点击屏幕重新加载"))
        messageLabel.attributedText = attStr
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }
    
    deinit {
        print("销毁")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    func tapClick() -> () {
        myBlock?()
//        self.removeFromSuperview()
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
