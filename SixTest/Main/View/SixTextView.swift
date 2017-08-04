//
//  SixTextView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class SixTextView: UITextView {

    var placeholder:String? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var placeholderColor:UIColor? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override var text: String!{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont?{
        didSet{
            super.font = font
            setNeedsDisplay()
        }
    }
    
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name(rawValue: "UITextViewTextDidChange"), object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    override func draw(_ rect: CGRect) {
        
        if hasText {
            return
        }
        
        var attrs = [String:Any]()
        attrs[NSFontAttributeName] = font
        attrs[NSForegroundColorAttributeName] = placeholderColor ?? UIColor.gray
        //画文字
        let placeholderRect = CGRect(x: 5, y: 5, width: rect.size.width - 10, height:  rect.size.height - 10)
        placeholder?.draw(in: placeholderRect, withAttributes: attrs)
        
    }
    // MARK: 自定义方法
    //监听文字改变
    func textDidChange(){
        //重绘
        setNeedsDisplay()
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
