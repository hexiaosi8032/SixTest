//
//  HintsBBSContentVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/23.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HintsBBSContentVC: UIViewController {
    
    var userId:String = ""
    var zanCount:Int = 0
    // MARK: 懒加载
    lazy var titleLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentTextView:UITextView = {
        let contentTextView = UITextView()
        contentTextView.font = adoptedFont(fontSize: 15)
        contentTextView.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        contentTextView.isUserInteractionEnabled = false
        return contentTextView
    }()
    
    lazy var zanBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "点赞-点击前"), for: .normal)
        btn.setImage(UIImage(named: "点赞-点击后"), for: .selected)
        btn.addTarget(self, action: #selector(zanBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    lazy var zanLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 30)
        titleLabel.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        
//        let size = contentLabel.text?.sizeWithFont(font: adoptedFont(fontSize: 15), maxW: ScreenWidth)
//        contentLabel.frame = CGRect(x: 0, y: titleLabel.bottom, width: size!.width, height: size!.height)
        contentTextView.frame = CGRect(x: 0, y: titleLabel.bottom, width: ScreenWidth, height: scaleY(y: 350))
        let zanBtnSize = zanBtn.currentImage?.size
        zanBtn.frame = CGRect(x: (ScreenWidth - zanBtnSize!.width) / 2, y: contentTextView.bottom + scaleY(y: 10), width: zanBtnSize!.width, height: zanBtnSize!.height)
        zanLabel.frame = CGRect(x: zanBtn.x, y: zanBtn.bottom, width: zanBtn.width, height: scaleY(y: 30))
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(titleLabel)
        view.addSubview(contentTextView)
        view.addSubview(zanBtn)
        view.addSubview(zanLabel)
        
        if userId != User.instance.userID {
            navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithTarget(target: self, action: #selector(rightItemClick), title: ". . .", titleColor: UIColorFromRGB(rgbValue: kWhiteColor))
        }

        getDatasAction()
        
        let defalut = UserDefaults()
        
        guard let topicId =  defalut.object(forKey: userId) as? String
            else {
                return
        }
        zanBtn.isSelected = userId == topicId
        zanBtn.isUserInteractionEnabled = !zanBtn.isSelected
    }
    
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    
    // MARK: Target方法
    func rightItemClick() -> () {
        
        AlertViewUtil.alertSheetShow(messages: ["举报"], controller: nil, confirmBlock: { (index) in
            switch index {
            case 0:
                print("举报")
                self.getJuBaoAction()
   
                break
            default:
                break
            }
        }, cancleBlock: nil)
    }
    
    func zanBtnClick() -> () {
        getZanAction()
    }
    
    // MARK: HTTP请求
    //帖子详情
    func getDatasAction() -> () {
        
        let hits = userId == User.sharedInstance().userID ? "0" : "1"
        let url = kHintsBBSContentPort
        var parameters = [String:Any]()
        parameters["userId"] = userId
        parameters["hits"] = hits//1：增加访问量 0：不增加访问量
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
 
            print(httpModel.data ?? "")
           
            
            guard let weakSelf = self,
                  let model = HintsBBSModel.mj_object(withKeyValues: httpModel.data as? NSDictionary)
                else {
                    AlertViewUtil.alertShow(message: "网络不好,请稍后再试", controller: nil, confirmTitle: "确定")
                    return
            }
            
            weakSelf.title = self?.getTitle(no: model.publishNoNow ?? "", nickName: model.nickName ?? "")
            weakSelf.titleLabel.text = "【\(model.title ?? "")】"
            weakSelf.contentTextView.text = model.content ?? ""
            weakSelf.zanCount = Int(model.upvote ?? "0") ?? 0
            weakSelf.zanLabel.text = "\(weakSelf.zanCount)赞"
            let status = model.status
            if weakSelf.userId == User.instance.userID {
                let titleString = status == "1" ? "审核中": status == "2" ? "审核通过" : "审核不通过"
                weakSelf.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithTarget(target:weakSelf, action: #selector(self?.rightItemClick), title: titleString, titleColor: UIColorFromRGB(rgbValue: kWhiteColor))
            }
            
        }) { (error:Error) in
            print(error)
            
        }
    }
    
    //点赞
    func getZanAction() -> () {
        
        let url = kLikeBBSTopicPort
        var parameters = [String:Any]()
        parameters["topicId"] = userId

        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            guard let weakSelf = self
                else {
                    return
            }
            
            weakSelf.zanBtn.isSelected = true
            weakSelf.zanBtn.isUserInteractionEnabled = !weakSelf.zanBtn.isSelected
            weakSelf.zanCount += 1
            weakSelf.zanLabel.text = "\(weakSelf.zanCount)赞"
            
            let defaul = UserDefaults()
            defaul.set(weakSelf.userId, forKey: weakSelf.userId)
            defaul.synchronize()
            
            print(httpModel.data ?? "")
            
        }) { (error:Error) in
            print(error)
            AlertViewUtil.alertShow(message: "点赞失败", controller: nil, confirmTitle: "确定")
        }
    }
    
    func getJuBaoAction() -> () {
        
        let url = kReportBBSTopicPort
        var parameters = [String:Any]()
        parameters["fromUserId"] = User.sharedInstance().userID// 举报用户的id
        parameters["toUserId"] = userId// 被举报用户id或被举报帖子的发帖用户的id
        parameters["content"] = ""// 举报内容，由举报用户填写
        parameters["type"] = "User"// Topic：举报帖子 User：举报用户
        
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            AlertViewUtil.alertShow(message: "举报成功", controller: nil, confirmTitle: "确定")
            print(httpModel.data ?? "")
            
        }) { (error:Error) in
            print(error)
            AlertViewUtil.alertShow(message: "举报失败", controller: nil, confirmTitle: "确定")
        }
    }
    
    func getTitle(no:String,nickName:String) -> String {
        
        let noStr = no.substring(from: no.index(no.startIndex, offsetBy: 9))
        return "\(noStr)期/\(nickName)"
    }
    // MARK: 代理和协议
 
}
