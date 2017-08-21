//
//  ZhuanjiaXinshuiChidVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//  专家心水子控制器

import UIKit
import MJExtension
import MJRefresh

class ZhuanjiaXinshuiChidVC: UIViewController {

    var type:KHintsType?
    var numberIndexList = 0
    var pageNum:Int = 1
    var typeStr:String = "月胜场"
    fileprivate var dataArr = [ZhuangjiaListModel]()
    
    // MARK: 懒加载
    lazy var headView:SixHeadView = {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 40))
        let headView = SixHeadView(frame: frame, titles: ["月胜场","查看数","时间",])
        headView.delegate = self
        return headView
    }()
    
    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect.zero, style: .plain)
        tabel.rowHeight = scaleY(y: 85)
        tabel.tableFooterView = UIView(frame: CGRect.zero)
        tabel.delegate = self
        tabel.dataSource = self
        return tabel
        }()
    
    lazy var errorView:SixErrorView = {
        [weak self] in
        let errorView:SixErrorView = SixErrorView(frame: self?.view.bounds ?? CGRect.zero, block: {
            self?.loadData(orderByType: self?.typeStr ?? "")
        })
        return errorView
        }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let y = headView.height
        myTabelView.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: view.height - y)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(headView)
        view.addSubview(myTabelView)
        
        loadData(orderByType: typeStr)
        
        myTabelView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            self?.pageNum = 1
            self?.loadData(orderByType: self?.typeStr ?? "")
        })
        
        myTabelView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            [weak self] in
            self?.pageNum += 1
            self?.loadData(orderByType: self?.typeStr ?? "")
        })
        
        myTabelView.mj_footer.isHidden = true
        
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    func loadData(orderByType:String) -> () {
        
        let url = kProfessionalHintsListPort;
        var parameters = [String:Any]()
        parameters["recommendType"] = DataService.hintsTypeStringFormType(type: type!)//心水类别
        //排序方式 月胜场(toMonthWins)、查看数 (toCheckNum)、修改时间(toTime)
        parameters["orderByType"]   = DataService.hintsOrderTypeFromName(name: orderByType)
        parameters["pageNum"]   = (pageNum)//需要显示的页数
        parameters["reverse"]   = (0)//排序方式（0-正序 1-倒序）
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            let responseObject = httpModel.data as? NSDictionary ?? [:]
            
            if self?.pageNum == 1 {
                self?.dataArr.removeAll()
            }
 
            let arr:[ZhuangjiaListModel] = ZhuangjiaListModel.mj_objectArray(withKeyValuesArray: responseObject["list"] as? NSArray) as! [ZhuangjiaListModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            self?.myTabelView.mj_header.endRefreshing()
            self?.myTabelView.mj_footer.endRefreshing()
            self?.myTabelView.mj_footer.isHidden = (self?.dataArr.count == 0)
            if arr.count == 0 {
                self?.myTabelView.mj_footer.endRefreshingWithNoMoreData()
            }
            self?.errorView.removeFromSuperview()
        }) {
            [weak self]
            (httpModel:HttpModel) in
            self?.view.addSubview(self?.errorView ?? UIView())
            self?.myTabelView.mj_header.endRefreshing()
            self?.myTabelView.mj_footer.endRefreshing()
            print(httpModel.message ?? "")
        }
    }

    // MARK: 代理和协议

}

extension ZhuanjiaXinshuiChidVC:UITableViewDelegate,UITableViewDataSource,SixHeadViewDelegate,ZhuangjiaCelldelegate{
    
    func btnClick(_ index: Int, btn: UIButton) {
        pageNum = 1
        typeStr = btn.currentTitle!
        loadData(orderByType: btn.currentTitle!)
    }
    
    
    func click(cell: ZhuangjiaCell, btn: UIButton) {
        if !User.sharedInstance().isLogin {
            let vc = LoginViewController()
            let nav = DataService.getSuperNav(controller: self)
            nav.pushViewController(vc, animated: true)
            return
        }
        
        //得到当前点击按钮所在位置
        let indexPath = myTabelView.indexPath(for: cell)
        let vc = LookZhuangjiaVC()
        vc.userid = dataArr[indexPath!.row].ID
        vc.type = type
        vc.isShowAllCurrentList = false
        let nav = DataService.getSuperNav(controller: self)
        nav.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ZhuangjiaCell.cellWithTableView(tableView)
        cell.model = dataArr[indexPath.row]
        cell.mydelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
 
        if !User.sharedInstance().isLogin {
            let vc = LoginViewController()
            let nav = DataService.getSuperNav(controller: self)
            nav.pushViewController(vc, animated: true)
            return
        }
        
        let vc = LookZhuangjiaVC()
        vc.userid = dataArr[indexPath.row].ID
        vc.type = type
        vc.isShowAllCurrentList = true
        let nav = DataService.getSuperNav(controller: self)
        
        nav.pushViewController(vc, animated: true)
    }
}
