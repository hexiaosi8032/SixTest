//
//  LookZhuangjiaCurrentContenVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/19.
//  Copyright © 2017年 小四. All rights reserved.
//  查看专辑本期控制器

import UIKit
import SDWebImage

class LookZhuangjiaCurrentContenVC: UIViewController {

    var nextPublishDateNo:String?
    var currentModel:ZhuangjiaCurrentHistoryModel?
    
    var infoModel:ZhuangjiaInfoModel? {
        didSet{
            imgView.sd_setImage(with: URL(string: infoModel?.headPortrait ?? ""), placeholderImage: UIImage(named: "默认头像"))
            userNameLabel.text = infoModel?.nickName
        }
    }
    
    // MARK: 懒加载
    lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var userNameLabel:UILabel = {
        let label = self.addLabel(fontSize: 16, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()

    lazy var contentView:LookZhuangjiaCurrentConetView = {
        let contentView = LookZhuangjiaCurrentConetView()
        return contentView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imgView.frame = CGRect(x: scaleX(x: 15) , y: 64 +  scaleY(y: 15), width: scaleX(x: 50), height: scaleX(x: 50))
        imgView.layer.cornerRadius = imgView.width / 2
        imgView.layer.masksToBounds = true
        
        userNameLabel.frame = CGRect(x: imgView.right + scaleX(x: 15), y: 64 + scaleY(y: 35), width: scaleX(x: 200), height: scaleY(y: 15))
        
        contentView.frame = CGRect(x: 0, y: imgView.bottom + scaleY(y: 15), width: ScreenWidth, height: ScreenHeight - imgView.bottom - scaleY(y: 15))
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "本期推荐"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
     
        view.addSubview(imgView)
        view.addSubview(userNameLabel)
        view.addSubview(contentView)
        
        contentView.nextPublishDateNo = nextPublishDateNo
        contentView.currentModel = currentModel
    }
    
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
