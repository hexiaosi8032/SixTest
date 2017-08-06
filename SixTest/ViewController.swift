//
//  ViewController.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = ""
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
    
        UIColorFromRGB(rgbValue: kMainThemeColor)
        
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议


}

