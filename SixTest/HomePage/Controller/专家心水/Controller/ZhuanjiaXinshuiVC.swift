//
//  ZhuanjiaXinshuiVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//  专家心水控制器

import UIKit

class ZhuanjiaXinshuiVC: UIViewController {

    var type:KSixType?
    
    // MARK: 懒加载
    lazy var titleStyleVC:MainTitleStyleVC = {
        let titleStyleVC = MainTitleStyleVC()
        titleStyleVC.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
        titleStyleVC.delegate = self
        
        for vc in DataService.getViewControllers(self.type!){
            
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

        navigationItem.titleView = SixNavLabel(topTitle: "特肖", bottomTitle: "2017-03-09 第028期")
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let backItem = UIBarButtonItem(image: UIImage(named:"返回")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backItemClick))
        let searchItem =  UIBarButtonItem(image: UIImage(named:"专家_搜索Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchItemClick))

        navigationItem.leftBarButtonItems = [backItem,searchItem]
        
        let xinshuiItem = UIBarButtonItem(image: UIImage(named:"专家_写Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(xinshuiItemClick))
        let paihangItem =  UIBarButtonItem(image: UIImage(named:"专家_排行榜Icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(paihangItemClick))
        paihangItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        navigationItem.rightBarButtonItems = [paihangItem,xinshuiItem]
        
        view.addSubview(titleStyleVC.view)
    }
    
    // MARK: Target方法
    func backItemClick() -> () {
        navigationController?.popViewController(animated: true)
    }
    
    func xinshuiItemClick() -> () {
        
    }
    
    func searchItemClick() -> () {
        let vc = SearchZhuangjiaVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func paihangItemClick() -> () {
        let vc = PaiHangBangListVC()
        vc.title = "排行榜"
        vc.type = KSixType.KSixZhuanjiaPaiHangType
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}

extension ZhuanjiaXinshuiVC:titleStyleClickDelegate{

    func clickBtn(_ index: Int) {
        title = DataService.hintsitleFromType(type: KHintsType(rawValue: index)!)
    }

  
}
