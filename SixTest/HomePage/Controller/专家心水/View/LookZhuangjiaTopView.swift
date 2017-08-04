//
//  SearchZhuangjiaTopView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/16.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol LookZhuangjiaTopViewDelegate : NSObjectProtocol{
    func attentionBtnClick(btn:UIButton)
}


class LookZhuangjiaTopView: UIView {
    
    // MARK: didSet
    var model:ZhuangjiaInfoModel? {
        didSet{
            
            imgView.sd_setImage(with: URL(string: model?.headPortrait ?? ""), placeholderImage: UIImage(named: "默认头像"))
            userNameLabel.text = model?.nickName
            fansLabel.text     = "粉丝数 :\(model?.fansCount ?? "")"
            totolLabel.text    = "总心水 \(model?.totalCount ?? "")"
            winLabel.text      = "胜 \(model?.winCount ?? "")"
            defeatLabel.text   = "负 \(model?.lostCount ?? "")"
            winrateLabel.text  = "胜率 \(model?.winninPercentage ?? "")"
            
            winLabel.attributedText = winLabel.addContentColor(title: winLabel.text ?? "", changeTitle: model?.winCount ?? "", changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
            defeatLabel.attributedText = defeatLabel.addContentColor(title: defeatLabel.text ?? "", changeTitle: model?.lostCount ?? "", changeTitleColor: UIColorFromRGB(rgbValue: kNGDGreenColor))
            winrateLabel.attributedText = winrateLabel.addContentColor(title: winrateLabel.text ?? "", changeTitle: model?.winninPercentage ?? "", changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
        }
    }
    
    var isfollowed:String? {
        didSet{
            attentionBtn.isSelected = isfollowed == "true"
            let title = isfollowed == "true" ? "取消关注" : "+ 关注"
            let color = isfollowed == "true" ? UIColorFromRGB(rgbValue: kNGDGreenColor) : UIColorFromRGB(rgbValue: kMainThemeColor)
            
            attentionBtn.setTitle(title, for: .normal)
            attentionBtn.setTitleColor(color, for: .normal)
        }
    }
    var mydelegate:LookZhuangjiaTopViewDelegate?
    
    // MARK: 懒加载
    lazy var sectionView:SixHeadView = {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 40))
        let sectionView = SixHeadView(frame: frame, titles: ["本期推荐","历史推荐"])
        return sectionView
    }()
    
    lazy var attentionBtn:UIButton = {
        let attentionBtn = UIButton(type: .custom)
        attentionBtn.titleLabel?.font = adoptedFont(fontSize: 14)
        attentionBtn.addTarget(self, action: #selector(attentionBtnClick), for: .touchUpInside)
        return attentionBtn
    }()
    
    lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var userNameLabel:UILabel = {
        let label = self.addLabel(fontSize: 16, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()
    
    lazy var fansLabel:UILabel = {
        let label = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()
    
    //总心水
    lazy var totolLabel:UILabel = {
        let label = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return label
    }()
    
    //胜
    lazy var winLabel:UILabel = {
        let label = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return label
    }()
    
    //负
    lazy var defeatLabel:UILabel = {
        let label = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return label
    }()
    
    //胜率
    lazy var winrateLabel:UILabel = {
        let label = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return label
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionView)
        addSubview(attentionBtn)
        addSubview(imgView)
        addSubview(line)
        addSubview(userNameLabel)
        addSubview(fansLabel)
        addSubview(totolLabel)
        addSubview(winLabel)
        addSubview(defeatLabel)
        addSubview(winrateLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionView.frame = CGRect(x: 0, y: height - 40, width: ScreenWidth, height: scaleY(y: 40))
        attentionBtn.frame = CGRect(x: width - scaleX(x: 25 + 60), y: scaleY(y: 25), width: scaleX(x: 60), height: scaleY(y: 15))
        let maiginX = scaleX(x: 15)
        let labelMargin = scaleY(y: 10)
        imgView.frame = CGRect(x: maiginX , y: scaleY(y: 15), width: scaleX(x: 55), height: scaleX(x: 55))
        imgView.layer.cornerRadius = imgView.width / 2
        imgView.layer.masksToBounds = true
        line.frame = CGRect(x: imgView.right + scaleX(x: 15), y: scaleY(y: 15), width: 1, height: scaleY(y: 60))
        
        let labelX = line.right + maiginX
        let labelH  = scaleY(y: 15)
        userNameLabel.frame = CGRect(x: labelX, y: labelMargin, width: scaleX(x: 120), height: labelH)
        fansLabel.frame = CGRect(x: labelX, y: userNameLabel.bottom + labelMargin, width: scaleX(x: 120), height: labelH)
        
        let bottomY = fansLabel.bottom + labelMargin
        totolLabel.frame = CGRect(x: labelX, y: bottomY , width: scaleX(x: 65), height: labelH)
        winLabel.frame = CGRect(x: totolLabel.right + scaleX(x: 10), y: bottomY, width: scaleX(x: 37), height: labelH)
        defeatLabel.frame = CGRect(x: winLabel.right + scaleX(x: 10), y: bottomY, width: scaleX(x: 37), height: labelH)
        winrateLabel.frame = CGRect(x: defeatLabel.right + scaleX(x: 10), y: bottomY, width: scaleX(x: 80), height: labelH)
        
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
    func attentionBtnClick(btn:UIButton) -> () {
        mydelegate?.attentionBtnClick(btn: btn)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
    
    
}
