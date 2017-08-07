//
//  MeVC.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class MeVC: UIViewController {

    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "我的"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let loginBtn = UIButton(type: UIButtonType.custom)
        loginBtn.setTitle("去登录", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        loginBtn.titleLabel?.font = adoptedFont(fontSize: 15)
        loginBtn.frame = CGRect(x: 100, y: 300, width: ScreenWidth - 200, height: 30)
        loginBtn.backgroundColor = UIColor.red
        loginBtn.addTarget(self, action: #selector(goLoginClick), for: UIControlEvents.touchUpInside)
        view.addSubview(loginBtn)
    }
    
    // MARK: Target方法
    func goLoginClick() -> () {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
