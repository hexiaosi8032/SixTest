//
//  MainTabBarVC.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addchildVCs()
        
    }

    func addchildVCs(){
        addChildViewController(HomeVC(), title: "六合彩", imageName: "首页_未选中", selectImageName: "首页_选中")
        addChildViewController(DataAnalysisVC(), title: "资料库", imageName: "资料_未选中", selectImageName: "资料_选中")
        addChildViewController(EntertainmentVC(), title: "娱乐区", imageName: "娱乐_未选中", selectImageName: "娱乐_选中")
        addChildViewController(MeVC(), title: "我的", imageName: "我的_未选中", selectImageName: "我的_选中")
    }
    
    func addChildViewController(_ childVC: UIViewController,title:String,imageName:String,selectImageName:String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named:imageName)
        childVC.tabBarItem.selectedImage = UIImage(named:selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        var textAttrs = [String:Any]()
        textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(rgbValue: 0x666666)
        textAttrs[NSFontAttributeName] = adoptedFont(fontSize: 12)
        
        var selectTextAttrs = [String:Any]()
        selectTextAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(rgbValue: kMainThemeColor)
        selectTextAttrs[NSFontAttributeName] = adoptedFont(fontSize: 12)
        
        //设置文字样式
        childVC.tabBarItem.setTitleTextAttributes(textAttrs, for: .normal)
        childVC.tabBarItem.setTitleTextAttributes(selectTextAttrs, for: .selected)
       
        let nav = MainNavigationVC()
        nav.addChildViewController(childVC)
        
        addChildViewController(nav)
    }
    
}
