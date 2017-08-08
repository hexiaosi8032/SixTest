//
//  ZhuanjiaXinshuiChidVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//  专家心水子控制器

import UIKit
import MJExtension

class ZhuanjiaXinshuiChidVC: UIViewController {

    var type:KHintsType?
    var numberIndexList = 0
    
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
        tabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tabel.delegate = self
        tabel.dataSource = self
        return tabel
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
        
        getDatasAction(orderByType: "月胜场")
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    func getDatasAction(orderByType:String) -> () {
        
        let url = kProfessionalHintsListPort;
        var parameters = [String:Any]()
        parameters["recommendType"] = DataService.hintsTypeStringFormType(type: type!)//心水类别
        //排序方式 月胜场(toMonthWins)、查看数 (toCheckNum)、修改时间(toTime)
        parameters["orderByType"]   = DataService.hintsOrderTypeFromName(name: orderByType)
        parameters["pageNum"]   = (1)//需要显示的页数
        parameters["reverse"]   = (0)//排序方式（0-正序 1-倒序）
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr.removeAll()
            
            let responseObject = httpModel.data?["list"] as? NSArray
            print(responseObject ?? "")
            
            let arr:[ZhuangjiaListModel] = ZhuangjiaListModel.mj_objectArray(withKeyValuesArray: responseObject) as! [ZhuangjiaListModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (error:Error) in
            print(error)
        }
        
    }

    // MARK: 代理和协议

}

extension ZhuanjiaXinshuiChidVC:UITableViewDelegate,UITableViewDataSource,SixHeadViewDelegate,ZhuangjiaCelldelegate{
    
    func btnClick(_ index: Int, btn: UIButton) {
        getDatasAction(orderByType: btn.currentTitle!)
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
