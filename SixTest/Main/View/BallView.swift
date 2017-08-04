//
//  BallView.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class BallView: UIButton {

     enum ballType{
        case ballTypeGreen
        case ballTypeRed
        case ballTypeBlue
    }
    
    var text:String = ""{
        didSet{
            setTitle(String(format: "%02d", NSInteger(text)!), for: .normal)
        }
    }
    
    var textFont:UIFont = UIFont.systemFont(ofSize: 11){
        didSet{
            titleLabel?.font = textFont
        }
    }
    
    var type:ballType = .ballTypeGreen{
        didSet{
            switch type {
            case .ballTypeRed:
                setBackgroundImage(UIImage(named: "红波"), for: .normal)
                break;
            case .ballTypeBlue:
                setBackgroundImage(UIImage(named: "蓝波"), for: .normal)
                break;
            default:
                setBackgroundImage(UIImage(named: "绿波"), for: .normal)
                break;
            }
            
        }
    }
    
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        contentEdgeInsets = UIEdgeInsetsMake(0, -scaleX(x: frame.size.width * 0.2), 0, 0)
        setTitleColor(UIColorFromRGB(rgbValue: kBlackFontColor), for: .normal)
        
    }
    
    //重写frame
    override var frame:CGRect{
        didSet {
            isUserInteractionEnabled = false
            contentEdgeInsets = UIEdgeInsetsMake(0, -scaleX(x: frame.size.width * 0.2), 0, 0)
            setTitleColor(UIColorFromRGB(rgbValue: kBlackFontColor), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议
    
}
