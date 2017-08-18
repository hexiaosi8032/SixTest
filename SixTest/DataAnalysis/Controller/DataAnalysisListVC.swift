//
//  DataAnalysisListVC.swift
//  SixTest
//
//  Created by hxs on 2017/8/18.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension
import MJRefresh

class DataAnalysisListVC: UIViewController {

    var typeId:String?
    var pageNum:Int = 1
    fileprivate var dataArr = [DataAnalysisListModel]()
    
    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), style: .plain)
        tabel.tableFooterView = UIView(frame: CGRect.zero)
        tabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tabel.delegate = self
        tabel.dataSource = self
        tabel.register(UINib(nibName: "ChatListCell", bundle: nil), forCellReuseIdentifier: "ChatListCell")
        
        tabel.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            self?.pageNum = 1
            self?.loadData()
        })
        
        tabel.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            [weak self] in
            self?.pageNum += 1
            self?.loadData()
        })
        
        return tabel
        }()
    
    lazy var errorView:SixErrorView = {
        [weak self] in
        let errorView:SixErrorView = SixErrorView(frame: self?.view.bounds ?? CGRect.zero, block: {
            self?.loadData()
        })
        return errorView
        }()
    
    lazy var nullView:SixNullView = {
        let nullView = SixNullView(frame: self.view.bounds)
        return nullView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
        
    }
    
    deinit {
        print("销毁")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    
    //日期控件的点击
    
    // MARK: HTTP请求
    func loadData() -> () {
        
        let url = kDataListPort
        var parameters = [String:Any]()
        parameters["typeId"] = typeId!
        parameters["pageNum"] = (pageNum)
        
        print(errorView)
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.myTabelView.mj_header.endRefreshing()
            self?.myTabelView.mj_footer.endRefreshing()
            
            guard let dic = httpModel.data as? NSDictionary
                else{
                    return
            }
            
            let arr:[DataAnalysisListModel] = DataAnalysisListModel.mj_objectArray(withKeyValuesArray: dic["list"]) as! [DataAnalysisListModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            self?.errorView.removeFromSuperview()
            self?.nullView.removeFromSuperview()
            
            if arr.count == 0 {
                self?.myTabelView.mj_footer.endRefreshingWithNoMoreData()
            }
            
            if self?.dataArr.count == 0{
                self?.view.addSubview((self?.nullView)!)
            }
            
        }) {
            [weak self]
            (httpModel:HttpModel) in
            self?.myTabelView.mj_header.endRefreshing()
            self?.myTabelView.mj_footer.endRefreshing()
            self?.view.addSubview((self?.errorView)!)
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议
    
}

extension DataAnalysisListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArr[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTabelView.mj_footer.isHidden = (dataArr.count == 0)
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
  
        let model = dataArr[indexPath.row]
        let vc = CommentVC()
        vc.idStr = model.ID ?? "";
        vc.title = model.title
        vc.h5ContentStr = model.content ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
