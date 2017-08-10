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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
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
        
        let headBgView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        headBgView.backgroundColor = UIColor.red
        view.addSubview(headBgView)
        
        let titleLabel = UILabel(frame: CGRect(x: (ScreenWidth - 100) / 2, y: 20, width: 100, height: 44))
        titleLabel.text = title
        titleLabel.font = adoptedFont(fontSize: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        headBgView.addSubview(titleLabel)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 30, width: 40, height: 24)
        button.setImage(UIImage(named: "返回"), for: .normal)
        button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        headBgView.addSubview(button)
        
    }
    
    // MARK: Target方法
    func loginClick() -> () {
        
        guard let _ = User.sharedInstance().AESKey else {
            loadAESData()
            return
        }
        
        loadLoginData()
    }
    
    func backClick() -> () {
        if (navigationController != nil) {
            navigationController?.popViewController(animated: true)
        }else{
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    // MARK: HTTP请求
    func loadAESData() -> () {
        let url = kGenerateAESKeyPort;
        var parameters = [String:Any]()
        
        parameters["rsaPublicKey"] = RSAHelper.shareInstance().getPublishKey()
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            if var cookies:String = httpModel.responseHeader["Set-Cookie"] as? String {
                let temp = NSString(string: cookies)
                let positon = temp.range(of: ";")
                cookies = temp.substring(with: NSMakeRange(0, positon.location))
                User.sharedInstance().sessionID = cookies
            }
        
            let AESKey = RSAHelper.shareInstance().decrypted(httpModel.data! as! String)
            User.sharedInstance().AESKey = AESKey
            
            print(httpModel.data!)
            
            self?.loadLoginData()
            
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
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
            print(httpModel.data ?? "")
            
            User.sharedInstance().setValuesForKeys(httpModel.data as! [String : Any])
            User.sharedInstance().isLogin = true
            
            let dic = User.sharedInstance().mj_keyValues()
//            var dic = httpModel.data as! [String:Any]
//            dic["isLogin"] = (true)
            let defaul = UserDefaults()
            defaul.set(dic, forKey: "user")
            defaul.synchronize()
 
            if ((self?.navigationController) != nil) {
                self?.navigationController?.popViewController(animated: true)
            }else{
                self?.dismiss(animated: true, completion: { 
                    self?.block?()
                })
            }
            
            print(httpModel.data!)
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
    }
    
}
