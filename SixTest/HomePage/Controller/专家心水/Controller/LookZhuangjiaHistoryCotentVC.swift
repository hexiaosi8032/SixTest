//
//  LookZhuangjiaHistoryCotentVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class LookZhuangjiaHistoryCotentVC: UIViewController {

    var infoModel:ZhuangjiaInfoModel? {
        didSet{
            
        }
    }
    
    var contentModel:ZhuangjiaCurrentHistoryModel?
    
    var publishDateNo:String?
    
    // MARK: 懒加载
    
    lazy var contentView:LookZhuangjiaHistoryContentView = {
        let contentView = LookZhuangjiaHistoryContentView()
        contentView.infoModel = self.infoModel
        contentView.currentModel = self.contentModel
        return contentView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getDatasAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "查看专家"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
      
        contentView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    func getDatasAction() -> () {
        
        let url = kSinglePublishResultPort;
        var parameters = [String:Any]()
        parameters["publishDateNo"] = publishDateNo//开奖期号（如：20161025-006）
    
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
 
            let responseObject = httpModel.data?["list"] as? NSArray
            
            let arr:[ZhuangjiaHistoryContentModel] = ZhuangjiaHistoryContentModel.mj_objectArray(withKeyValuesArray: responseObject) as! [ZhuangjiaHistoryContentModel]
            
            self?.contentView.dataArr = arr
            self?.view.addSubview((self?.contentView)!)
            
            
            print(httpModel.data ?? "")
     
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议

}
