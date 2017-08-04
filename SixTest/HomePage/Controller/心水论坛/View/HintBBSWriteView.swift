//
//  HintBBSWriteView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

@objc protocol HintBBSWriteViewdelegate : NSObjectProtocol {
    func click(title:String,content:String)
}

class HintBBSWriteView: UIView {
 
    var mydelegate:HintBBSWriteViewdelegate?
    var model:HintsBBSModel? {
        didSet{
    
            titleTextField.text = model?.title
            contentTextView.text = model?.content
            titleTextField.isUserInteractionEnabled = false
            contentTextView.isUserInteractionEnabled = false
            fabuBtn.isUserInteractionEnabled = false
            fabuBtn.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        }
        
    }
 
    
    // MARK: 懒加载
    lazy var titleLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        label.text = "标题"
        return label
    }()
    
    lazy var line:UIView = {
        let line:UIView = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var contentLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        label.text = "内容 (填写内容50字以上)"
        let attStr:NSMutableAttributedString = NSMutableAttributedString(string: label.text!)
        attStr.addAttributes([NSForegroundColorAttributeName : UIColorFromRGB(rgbValue: kLightGrayFontColor)], range: NSString(string: label.text!).range(of: "(填写内容50字以上)"))
        attStr.addAttributes([NSFontAttributeName : adoptedFont(fontSize: 11)], range: NSString(string: label.text!).range(of: "(填写内容50字以上)"))
        label.attributedText = attStr
        return label
    }()
    
    
    lazy var titleTextField:UITextField = {
        let textF = UITextField()
        textF.font = adoptedFont(fontSize: 14)
        textF.placeholder = " 请输入标题(30字以内)"
        textF.returnKeyType = .done
        textF.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        textF.delegate = self
        return textF
    }()
    
    lazy var contentTextView:SixTextView = {
        let contentTextView:SixTextView = SixTextView()
        contentTextView.font = adoptedFont(fontSize: 14)
        contentTextView.placeholder = "请输入内容"
        contentTextView.placeholderColor = UIColorFromRGB(rgbValue: kLightGrayFontColor)
        contentTextView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        contentTextView.returnKeyType = .done
        contentTextView.delegate = self
        return contentTextView
    }()
    
    lazy var fabuBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("发布", for: UIControlState.normal)
        btn.backgroundColor = UIColorFromRGB(rgbValue: kMainThemeColor)
        btn.titleLabel?.font = adoptedFont(fontSize: 15)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(fabuBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    lazy var warningLabel: UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        label.numberOfLines = 0
        label.text = "本论坛为心水总专用，发布内容可自由发挥，每期只能编辑一次内容，普通用户发布帖子需要人工审核后才能显示到列表，请勿发布联系方式和广告，一经发现直接封号"
        label.attributedText = label.addContentColor(title: label.text!, changeTitle: "请勿", changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
        return label
    }()
    
    // MARK: 初始化和生命周期 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(line)
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(fabuBtn)
        addSubview(warningLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let x = scaleX(x: 13)
        titleLabel.frame = CGRect(x: x, y: scaleY(y: 10), width: scaleX(x: 33), height: scaleY(y: 15))
        titleTextField.frame = CGRect(x: titleLabel.right + scaleX(x: 5), y: scaleY(y: 5), width: scaleX(x: 315), height: scaleY(y: 25))
        line.frame = CGRect(x: 0, y: titleTextField.bottom + scaleY(y: 5), width: ScreenWidth, height: 0.5)
        contentLabel.frame = CGRect(x: x, y: line.bottom + scaleY(y: 10), width: width, height: scaleY(y: 15))

        contentTextView.frame = CGRect(x: x, y: contentLabel.bottom + scaleY(y: 10), width: width - x * 2, height: scaleY(y: 266))
        fabuBtn.frame = CGRect(x: (width - scaleX(x: 285)) / 2, y: contentTextView.bottom + scaleY(y: 10), width: scaleX(x: 285), height: scaleY(y: 40))
        warningLabel.frame = CGRect(x: x, y: fabuBtn.bottom + scaleY(y: 10), width: width - x * 2, height: scaleY(y: 100))
        
        titleTextField.layer.cornerRadius = 5
        titleTextField.layer.masksToBounds = true
        contentTextView.layer.cornerRadius = 5
        contentTextView.layer.masksToBounds = true
        
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
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    
    // MARK: Target方法
    func fabuBtnClick(btn:UIButton) -> () {
        mydelegate?.click(title: titleTextField.text ?? "", content: contentTextView.text ?? "")
    }
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}

extension HintBBSWriteView:UITextFieldDelegate,UITextViewDelegate{
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UITextViewDelegate
    //将要开始编辑
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    //结束编辑
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    //响应Done键
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        
        //不能输入空格
        if text == " "{
            return false
        }
        
        ////输入文字限制,不超过100
        if range.location > 100{
            textView.text = textView.text.substring(to: textView.text.index(textView.text.startIndex, offsetBy: 100))
            return false
        }
        
        return true
    }
    
}

