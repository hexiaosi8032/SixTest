//
//  HomeVC.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension
 

class HomeVC: UIViewController,HomeResultViewdelegate,HomeListViewdelegate{

    // MARK: 懒加载
    lazy var bgView:HomeBgView = {
        let bgView = HomeBgView()
        bgView.resuletView.delegate = self
        bgView.listView.delegate = self
        return bgView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getDatasAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bgView.frame = CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight - TabBarHeight)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        title = "首页"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let moreItem = UIBarButtonItem(image: UIImage(named:"更多菜单")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(moreItemClick))
        
        let redbagItem =  UIBarButtonItem(image: UIImage(named:"红包入口")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(redbagItemClick))
        
        navigationItem.rightBarButtonItems = [moreItem,redbagItem]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithTarget(target: self, action: #selector(chatRoomItemClick), title: "聊码大厅", titleColor:  UIColorFromRGB(rgbValue: kWhiteColor))
        
        view.addSubview(bgView)
        
    }
    
    // MARK: Target方法
    func voiceBtnClick() -> () {
        
    }
    
    //历史记录
    func historyBtnClick() -> () {
        let vc = HistoryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //更多
    func moreItemClick() -> () {
      
    }
    
    //红包
    func redbagItemClick() -> () {
        
    }
    
    //聊天室
    func chatRoomItemClick() -> () {
        
    }
    
    func iconClick(index: NSInteger) {
        switch index {
        case 0:
            print("专家心水")
            let vc = ZhuanjiaXinshuiVC()
            vc.type = KSixType.KSixZhuanjiaXinshuiType
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            print("人人料")
            let vc = RenrenLiaoVC()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = HintsBBSVC()
            navigationController?.pushViewController(vc, animated: true)
            
            print("心水论坛")
            break
        case 3:
            print("查询助手")
            break
        case 4:
            print("投票互动")
            break
        default:
            break
        }
    }
    
    // MARK: HTTP请求
    func getDatasAction() -> () {
        
        let url = kPublishResultPort;
        let parameters = [String:Any]()
      
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            
            [weak self]
            (httpModel:HttpModel) in
            
            let responseObject = httpModel.data as? NSDictionary
            
            let resultMoldel = HomeResultModel.mj_object(withKeyValues:responseObject?["lotteryRecord"])
            let nextPublishInfo = HomeNextModel.mj_object(withKeyValues: responseObject?["nextPublishInfo"])
            resultMoldel?.nextPublishInfo = nextPublishInfo
            User.sharedInstance().publishDateNo = (responseObject?["nextPublishInfo"] as? NSDictionary)?["publishDateNo"] as? String
            
            self?.bgView.refresh(resultMoldel!)
            
        }) { (error:Error) in
             print(error)
     
        }
    
    }
    // MARK: 代理和协议

}
