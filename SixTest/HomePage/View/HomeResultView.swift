//
//  HomeResultView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

@objc protocol HomeResultViewdelegate : NSObjectProtocol {
    func voiceBtnClick()
    func historyBtnClick()
}

class HomeResultView: UIView {

    var delegate : HomeResultViewdelegate?
    
    // MARK: 懒加载
    lazy var resultLabel:UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = adoptedFont(fontSize: 15)
        resultLabel.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        return resultLabel
    }()
    
    private lazy var voiceButton:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "声音开"), for: .normal)
        btn.setImage(UIImage(named: "声音关"), for: .selected)
        btn.addTarget(self, action: #selector(voiceBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var historyButton:UIButton = {
        let btn = SelectBtn(type: .custom)
        btn.type = .btnTypeImageRight
        btn.margin = scaleX(x: 10)
        btn.titleLabel?.font = adoptedFont(fontSize: 13)
        btn.setTitleColor(UIColorFromRGB(rgbValue: kNGDBlackFontColor), for: .normal)
        btn.setTitle("历史记录", for: .normal)
        btn.setImage(UIImage(named: "历史记录箭头"), for: .normal)
        btn.addTarget(self, action: #selector(historyBtnClick), for: .touchUpInside)
        return btn
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(resultLabel)
        self.addSubview(voiceButton)
        self.addSubview(historyButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let height  = frame.size.height
        let width   = frame.size.width
        resultLabel.frame = CGRect(x: scaleX(x: 15), y: 0, width: scaleX(x: 130), height: height)
        voiceButton.frame = CGRect(x: resultLabel.frame.maxX + scaleX(x: 10), y: (height - scaleX(x: 30)) / 2, width: scaleX(x: 30), height: scaleX(x: 30))
        
        let historyW = scaleX(x: 80)
        historyButton.frame = CGRect(x: width - historyW - scaleX(x: 10), y: 0, width: historyW, height: height)
    }
    // MARK: 自定义方法
 
    // MARK: Target方法
    func voiceBtnClick(btn:UIButton) -> () {
        btn.isSelected = !btn.isSelected
        delegate?.voiceBtnClick()
    }
    
    func historyBtnClick(btn:UIButton) -> () {
        btn.isSelected = !btn.isSelected
        delegate?.historyBtnClick()
    }
    
    // MARK: HTTP请求


}
