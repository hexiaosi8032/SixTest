//
//  MainNavigationVC.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class MainNavigationVC: UINavigationController {

    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        navigationBar.barTintColor = UIColorFromRGB(rgbValue: kMainThemeColor)
        
        var textAttrs = [String:Any]()
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
        textAttrs[NSFontAttributeName] = adoptedFont(fontSize: 18)
        
        navigationBar.titleTextAttributes = textAttrs
    }
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0
        {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
            button.setImage(UIImage(named: "返回"), for: .normal)
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    // MARK: Target方法
    func click() -> () {
        popViewController(animated: true)
    }
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
