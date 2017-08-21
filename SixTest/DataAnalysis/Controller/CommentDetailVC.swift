//
//  CommentDetailVC.swift
//  SixTest
//
//  Created by hxs on 2017/8/7.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

class CommentDetailVC: UIViewController {

    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), style: .plain)
        tabel.tableFooterView = UIView(frame: CGRect.zero)
        tabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tabel.delegate = self
        tabel.dataSource = self
        return tabel
        }()
    
    fileprivate var dataArr = [CommentDeailModel]()
    var rootTopicId:String?
    var parentTopicId:String?
    var imgStr:String?
    var nameStr:String?
    var userRole:String?
    var timeStr:String?
    var content:String?
    var foolStr:String?
    var replyType:String?
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "共几条回复"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    func loadData() -> () {
        
        let url = kReplyChildQuery;
        var parameters = [String:Any]()
        parameters["type"] = replyType
        parameters["rootTopicId"] = rootTopicId!
        parameters["parentTopicId"] = parentTopicId
        parameters["pageNum"] = (1)
        parameters["pageSize"] = (10)
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            let responseObject = httpModel.data as? NSArray ?? []
            
            let arr:[CommentDeailModel] = CommentDeailModel.mj_objectArray(withKeyValuesArray: responseObject) as! [CommentDeailModel]
            let firstModel = CommentDeailModel()
            firstModel.imgStr = self?.imgStr
            firstModel.nameStr = self?.nameStr
            firstModel.userRole = self?.userRole
            firstModel.foolStr = "1楼"
            firstModel.timeStr = self?.timeStr
            firstModel.content = self?.content
            self?.dataArr.append(firstModel)
            for tempModel in arr{
                tempModel.nameStr = self?.nameStr
                self?.dataArr.append(tempModel)
            }
            
            self?.myTabelView.reloadData()
            print(responseObject)
 
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议
}

extension CommentDetailVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentDetailCell.cellWithTableView(tableView)
        cell.refresh(model: dataArr[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView(tableView, cellForRowAt: indexPath) as! CommentDetailCell

        return cell.cellH
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

