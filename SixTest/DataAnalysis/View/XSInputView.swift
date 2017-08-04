//
//  XSInputView.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class XSInputView: UITextView {

    var maxTextH:CGFloat = 0//文字最大高度
    var textH:CGFloat = 0//文字高度
    
    var maxNumberOfLines:Int = 0 {
        didSet{
            //ceil 返回大于或者等于
            // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
            maxTextH = ceil((font?.lineHeight)! * CGFloat(maxNumberOfLines) + textContainerInset.top + textContainerInset.bottom)
        }
    }
    
    var cornerRadius:CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    var xs_textHeightChangeBlock:((String,CGFloat) -> Void?)? {
        didSet{
            textDidChange()
        }
    }
    
    var placeholderColor:UIColor? {
        didSet{
            placeholderView.textColor = placeholderColor
        }
    }
    
    var placeholder:String? {
        didSet{
            placeholderView.text = placeholder
        }
    }
    
    override var text: String!{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    // MARK: 懒加载
    lazy var placeholderView:UITextView = {
        let placeholderView = UITextView()
        placeholderView.isScrollEnabled = false
        placeholderView.showsHorizontalScrollIndicator = false
        placeholderView.showsVerticalScrollIndicator = false
        placeholderView.isUserInteractionEnabled = false
        placeholderView.font = self.font
        placeholderView.textColor = UIColor.lightGray
        placeholderView.backgroundColor = UIColor.clear
        placeholderView.frame = self.bounds
        return placeholderView
    }()

    // MARK: 初始化和生命周期
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupUI()

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }

    // MARK: 自定义方法
    func setupUI() -> () {
        addSubview(placeholderView)
        isScrollEnabled = false
        scrollsToTop = false
        showsHorizontalScrollIndicator = false
        enablesReturnKeyAutomatically = true
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGray.cgColor
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name(rawValue: "UITextViewTextDidChange"), object: self)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: self)
    }
    
    //监听文字改变
    func textDidChange(){
        
        placeholderView.isHidden = text.characters.count > 0 ? true : false
        let height = ceil(sizeThatFits(CGSize(width: bounds.size.width, height: CGFloat(MAXFLOAT))).height)
        if textH != height { // 高度不一样，就改变了高度
            // 最大高度，可以滚动
            isScrollEnabled = height > maxTextH && maxTextH > 0
            textH = height
            if (xs_textHeightChangeBlock != nil) && isScrollEnabled == false {
                xs_textHeightChangeBlock!(text,height)
                superview?.layoutIfNeeded()
                placeholderView.frame = bounds
            }
        }
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议
    

    
}
