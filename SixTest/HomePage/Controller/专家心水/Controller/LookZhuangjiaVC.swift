//
//  LookZhuangjiaVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//  查看专家

import UIKit
import MJExtension

class LookZhuangjiaVC: UIViewController {
    
    var type:KHintsType?
    var userid:String?
    var isShowAllCurrentList:Bool = true //是否显示本期全部列表
    
    // MARK: 懒加载
    lazy var topView:LookZhuangjiaTopView = {
        let topView = LookZhuangjiaTopView()
        topView.sectionView.delegate = self
        topView.mydelegate = self
        return topView
    }()
    
    //本期推荐
    lazy var nowView:LookZhuangjiaNowView = {
        let nowView = LookZhuangjiaNowView(isShowAllCurrentList: self.isShowAllCurrentList)
        nowView.type = self.type
        nowView.superVC = self
        return nowView
    }()
    
    //历史推荐
    lazy var historyView:LookZhuangjiaHistoryView = {
        let historyView = LookZhuangjiaHistoryView()
        historyView.setupUseridWithsuperVC(userid: self.userid ?? "", superVC: self)
        return historyView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getRecommendDatasAction()
        
        getCheckIsAlreadyFollowedDatasAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
         topView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: scaleY(y: 120))
         nowView.frame = CGRect(x: 0, y: topView.bottom, width: ScreenWidth, height: ScreenHeight - topView.bottom)
         historyView.frame = nowView.frame
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        title = "查看专家"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let tieziItem = UIBarButtonItem.itemWithTarget(target: self, action: #selector(tieziItemClick), title: "心水帖子", titleColor: UIColor.white)
        navigationItem.rightBarButtonItem = tieziItem
        
        view.addSubview(topView)
        view.addSubview(nowView)
        view.addSubview(historyView)
        
        historyView.isHidden = true
        historyView.backgroundColor = UIColor.green
    }
    
    // MARK: Target方法
    func tieziItemClick() -> () {
        let vc = HintsBBSContentVC()
        vc.userId = userid ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: HTTP请求
    //本期推荐
    func getRecommendDatasAction() -> () {
        
        let url = kRecommendRecordThisPeriodListPort
        var parameters          = [String:Any]()
        parameters["userid"]  = userid//当前登录用户
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            
            let infoModel = ZhuangjiaInfoModel.mj_object(withKeyValues: httpModel.data?["userInfo"] as Any)
            self?.topView.model = infoModel
            
            self?.nowView.nextPublishDateNo = httpModel.data?["nextPublishDateNo"] as? String
            
            let responseObject = httpModel.data?["list"] as? NSArray
            
            let arr:[ZhuangjiaCurrentHistoryModel] = ZhuangjiaCurrentHistoryModel.mj_objectArray(withKeyValuesArray: responseObject) as! [ZhuangjiaCurrentHistoryModel]
            self?.nowView.dataArr = arr
            
    
            
        }) { (error:Error) in
            print(error)
          
        }
        
    }
    
    //查询是否已经被关注
    func getCheckIsAlreadyFollowedDatasAction() -> () {
        
        let url = kAPIGatewayPort;
        var parameters          = [String:Any]()
        parameters["operationType"] = "QUERY_USER_CAREFOR"
        parameters["userId"]  = User.sharedInstance().userID!//当前登录用户
        parameters["toUserId"]  = userid
        print(parameters)
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            //登录后回调
            if httpModel.statusCode == "USER_KEY_EXPIRE"{
                self?.getCheckIsAlreadyFollowedDatasAction()
                return
            }
            
            self?.topView.isfollowed = httpModel.data as? String
            
        }) { (error:Error) in
            print(error)
            
        }
        
    }
    
    //关注专家
    func getAttentionDatasAction(type:String) -> () {
        
        let url = kFollowExpertListPort;
        var parameters          = [String:Any]()
        parameters["userName"]  = User.sharedInstance().userName//当前登录用户
        parameters["toUserId"]  = userid
        parameters["type"]      = type//只能关注不能取消
 
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
     
            self?.topView.isfollowed = type == "add" ? "true" : "false"
 
        }) { (error:Error) in
            print(error)
 
        }
        
    }
    
    
    // MARK: 代理和协议
   
}

extension LookZhuangjiaVC:SixHeadViewDelegate,LookZhuangjiaTopViewDelegate{
    
    func btnClick(_ index: Int, btn: UIButton) {
        nowView.isHidden = index != 0
        historyView.isHidden = index == 0
    }
    
    func attentionBtnClick(btn: UIButton) {
        let type = btn.isSelected ? "delete" : "add"
        getAttentionDatasAction(type: type)
    }
}
