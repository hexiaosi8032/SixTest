//
//  LookZhuangjiaHistoryView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/17.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LookZhuangjiaHistoryView: UIView {
    
    // MARK: didSet
    
    // MARK: 懒加载
    lazy var titleStyleVC:MainTitleStyleVC = {
        let titleStyleVC = MainTitleStyleVC()
        
        for vc in DataService.getViewControllers(KSixType.KSixZhuanjiaHistoryType){
            
            titleStyleVC.addChildViewController(vc)
        }
        
        return titleStyleVC
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleStyleVC.view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleStyleVC.view.frame = bounds
        titleStyleVC.viewWillAppear(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    
    func setupUseridWithsuperVC(userid:String,superVC:LookZhuangjiaVC) -> () {
        for vc in titleStyleVC.childViewControllers{
            (vc as! LookZhuangjiaHistoryListVC).userid = userid
            (vc as! LookZhuangjiaHistoryListVC).superVC = superVC
        }
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
