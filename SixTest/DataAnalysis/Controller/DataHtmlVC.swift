//
//  DataHtmlVC.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class DataHtmlVC: UIViewController {

    var content:String = ""
    var idStr:String?
    var titleName:String?
    var replies:String?
    var createTime:String?
    
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = titleName
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            
            let attrStr = try! NSAttributedString(
                data: self.content.data(using: String.Encoding.unicode)!,
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            
            let frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 10), width: ScreenWidth - scaleX(x: 30), height: 0)
            let label = UILabel(frame: frame)
            label.numberOfLines = 0
            label.attributedText = attrStr
            label.sizeToFit()
            
            let headView = UIView(frame:CGRect(x: scaleX(x: 0), y: scaleY(y: 0), width: ScreenWidth, height: label.frame.maxY))
            headView.addSubview(label)
            
            let table = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64), style: UITableViewStyle.plain)
            self.view.addSubview(table)
            table.tableHeaderView = headView
            
        }
        
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
