//
//  LoginViewController.swift
//  SixTest
//
//  Created by hxs on 2017/8/7.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var block:(() -> Void)?
    
    // MARK: 懒加载
    lazy var userNameF:UITextField = {
        let userNameF = UITextField()
        userNameF.placeholder = "请输入账号"
        userNameF.clearButtonMode = .whileEditing
        userNameF.font = adoptedFont(fontSize: 15)
        userNameF.text = "15915333887"
        userNameF.layer.borderWidth = 0.5
        userNameF.layer.borderColor = UIColorFromRGB(rgbValue: kLineColor).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        userNameF.leftView = leftView
        userNameF.leftViewMode = .always
        return userNameF
    }()
    
    lazy var passWdF:UITextField = {
        let passWdF = UITextField()
        passWdF.placeholder = "请输入密码"
        passWdF.clearButtonMode = .whileEditing
        passWdF.isSecureTextEntry = true
        passWdF.font = adoptedFont(fontSize: 15)
        passWdF.text = "yan123456"
        passWdF.layer.borderWidth = 0.5
        passWdF.layer.borderColor = UIColorFromRGB(rgbValue: kLineColor).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        passWdF.leftView = leftView
        passWdF.leftViewMode = .always
        return passWdF
    }()
    
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton(type: UIButtonType.custom)
        loginBtn.setTitle("登录", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        loginBtn.titleLabel?.font = adoptedFont(fontSize: 15)
        loginBtn.addTarget(self, action: #selector(loginClick), for: UIControlEvents.touchUpInside)
        loginBtn.backgroundColor = UIColor.red
        return loginBtn
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupUI()
        
    }
    
    deinit {
        print("PickView销毁")
    }
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "登录"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(userNameF)
        view.addSubview(passWdF)
        view.addSubview(loginBtn)
        userNameF.frame = CGRect(x: 60, y: 130, width: ScreenWidth - 120, height: 30)
        passWdF.frame = CGRect(x: 60, y: userNameF.bottom + 30, width: ScreenWidth - 120, height: 30)
        loginBtn.frame = CGRect(x: 100, y: passWdF.bottom + 30, width: ScreenWidth - 200, height: 30)
        
    }
    
    // MARK: Target方法
    func loginClick() -> () {
        
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
        parameters["userName"] = userNameF.text
        parameters["password"]   = passWdF.text
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            //登录后回调
            if httpModel.statusCode == "USER_KEY_EXPIRE"{
                self?.loadLoginData()
                return
            }
            
            if ((self?.navigationController) != nil) {
                self?.navigationController?.popViewController(animated: true)
            }else{
                self?.dismiss(animated: true, completion: { 
                    self?.block?()
                })
            }
            
            print(httpModel.data!)
            
        }) { (error:Error) in
            print(error)
        }
    }
    
}