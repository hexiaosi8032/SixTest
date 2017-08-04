//
//  SixHeadView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

@objc protocol SixHeadViewDelegate : NSObjectProtocol{
    @objc optional func btnClick(_ index:Int,btn:UIButton)
    
}

class SixHeadView: UIView {

    var selectBtn:UIButton?
    var delegate:SixHeadViewDelegate?
    
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    init(frame: CGRect,titles:[String]) {
        super.init(frame: frame)

        backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        
        let btnW = (frame.size.width - scaleX(x: 13) * 2) / CGFloat(titles.count)
        let btnH = frame.size.height - scaleY(y: 5) * 2
        for i in 0..<titles.count {
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.white
            btn.titleLabel?.font = adoptedFont(fontSize: 14)
            btn.setTitle(titles[i], for: .normal)
            btn.setTitleColor(UIColorFromRGB(rgbValue: kWhiteColor), for: .selected)
            btn.setTitleColor(UIColorFromRGB(rgbValue: kNGDBlackFontColor), for: .normal)
            btn.setBackgroundImage(UIImage(named: "选中-红色"), for: .selected)
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColorFromRGB(rgbValue: kNGDLightGrayFontColor).cgColor
            btn.tag = 10 + i
            btn.frame = CGRect(x: scaleX(x: 13) + btnW * CGFloat(i), y: scaleY(y: 5), width: btnW, height: btnH)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            if i == 0 {
                btn.isSelected = true
                selectBtn = btn
            }
            addSubview(btn)
        }
 
        
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
    
    
    //重写frame
    override var frame:CGRect{
        didSet {
     
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 自定义方法
    func btnClick(btn:UIButton) -> () {
        
        if selectBtn == btn {
            return
        }
        
        selectBtn?.isSelected = false
        btn.isSelected = true
        selectBtn = btn
        
        delegate?.btnClick?(btn.tag - 10, btn: btn)
 
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议
    
}
