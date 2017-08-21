//
//  HintsBBSWriteVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HintsBBSWriteVC: UIViewController {

    // MARK: 懒加载
    lazy var writeView:HintBBSWriteView = {
        let writeView = HintBBSWriteView()
        writeView.mydelegate = self
        return writeView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getContentAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        writeView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "写心水"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(writeView)
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    func getContentAction() -> () {
        
        let hits = "0"
        let url = kHintsBBSContentPort
        var parameters = [String:Any]()
        parameters["userId"] = User.sharedInstance().userID
        parameters["hits"] = hits
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            print(httpModel.data ?? "")
            let responseObject = httpModel.data as? NSDictionary ?? [:]
            let model = HintsBBSModel.mj_object(withKeyValues: responseObject)
            self?.writeView.model = model
          
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
    }
    
    //写心水
    func getDatasAction(title:String,content:String) -> () {
        
        let url = kHintsBBSContentSubmitPort
        var parameters = [String:Any]()
        parameters["userName "] = User.sharedInstance().userName
        parameters["title"] = title
        parameters["content"] = content
        parameters["publishNo"] = User.sharedInstance().publishDateNo
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    

    // MARK: 代理和协议 kHintsBBSContentSubmitPort
}

extension HintsBBSWriteVC:HintBBSWriteViewdelegate{
    
    func click(title: String, content: String) {
        getDatasAction(title: title, content: content)
    }
}
