//
//  LoginVC.swift
//  SixTest
//
//  Created by IMAC on 2017/8/4.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWd: UITextField!
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

 
        title = "我的"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
    }

    // MARK: 自定义方法
    // MARK: Target方法
    @IBAction func loginAction(_ sender: Any) {
     
        guard let _ = User.sharedInstance().AESKey else {
            loadAESData()
            return
        }
        
        loadLoginData()
        
    }
    
    // MARK: HTTP请求
    func loadAESData() -> () {
        let url = kGenerateAESKeyPort;
        var parameters = [String:Any]()
    
        parameters["rsaPublicKey"] = RSAHelper.shareInstance().getPublishKey()
       
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            let AESKey = RSAHelper.shareInstance().decrypted(httpModel.data! as! String)
            User.sharedInstance().AESKey = AESKey
        
            print(httpModel.data!)
            
            self?.loadLoginData()
            
            
        }) { (error:Error) in
            print(error)
        }
    }
    
    func loadLoginData() -> () {
        let url = kAPIGatewayPort;
        var parameters = [String:Any]()
        parameters["operationType"] = "USER_LOGIN"
        parameters["userName"] = "15915333822"
        parameters["password"]   = "yan123456"
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            print(httpModel.data!)
            
        }) { (error:Error) in
            print(error)
        }
    }
    
}
