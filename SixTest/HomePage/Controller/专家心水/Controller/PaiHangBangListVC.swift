//
//  PaiHangBangListVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class PaiHangBangListVC: UIViewController {


    var type:KSixType = KSixType.KSixZhuanjiaPaiHangType
    
    // MARK: 懒加载
    lazy var titleStyleVC:MainTitleStyleVC = {
        let titleStyleVC = MainTitleStyleVC()
        titleStyleVC.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
        
        for vc in DataService.getViewControllers(self.type){
            
            titleStyleVC.addChildViewController(vc)
        }
        titleStyleVC.viewWillAppear(true)
        return titleStyleVC
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
 
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        if type ==  .KSixZhuanjiaPaiHangType{
            let jiangItem =  UIBarButtonItem(image: UIImage(named:"专家_奖Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(jiangItemClick))
            
            navigationItem.rightBarButtonItem = jiangItem
        }

        view.addSubview(titleStyleVC.view)
    }
    
    // MARK: Target方法
    func jiangItemClick() -> () {
        let vc = PaiHangBangListVC()
        vc.title = "奖赏榜"
        vc.type = KSixType.KSixZhuanjiaJiangShangType
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
