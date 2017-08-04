//
//  RenrenLiaoVC.swift
//  SixTest
//
//  Created by IMAC on 2017/7/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class RenrenLiaoVC: UIViewController {

    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        navigationItem.titleView = SixNavLabel(topTitle: "人人料", bottomTitle: "2017-03-09 第028期")
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let backItem = UIBarButtonItem(image: UIImage(named:"返回")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backItemClick))
        let searchItem =  UIBarButtonItem(image: UIImage(named:"专家_搜索Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchItemClick))
        
        navigationItem.leftBarButtonItems = [backItem,searchItem]
        
        let xinshuiItem = UIBarButtonItem(image: UIImage(named:"专家_写Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(xinshuiItemClick))
        let paihangItem =  UIBarButtonItem(image: UIImage(named:"专家_排行榜Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(paihangItemClick))
        paihangItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        navigationItem.rightBarButtonItems = [paihangItem,xinshuiItem]
        
    }
    
    // MARK: Target方法
    func backItemClick() -> () {
        navigationController?.popViewController(animated: true)
    }
    
    func xinshuiItemClick() -> () {
        
    }
    
    func searchItemClick() -> () {
      
    }
    
    func paihangItemClick() -> () {
 
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
