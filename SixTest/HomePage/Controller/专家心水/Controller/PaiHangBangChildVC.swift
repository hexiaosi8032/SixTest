//
//  PaiHangBangChildVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class PaiHangBangChildVC: UIViewController {

    var type:KHintsType?
    
    fileprivate var dataArr = [PaiHangBangModel]()
    // MARK: 懒加载
    lazy var headView:SixHeadView = {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 40))
        let headView = SixHeadView(frame: frame, titles: ["本月胜场","本月连胜榜"])
        headView.delegate = self
        return headView
    }()
    
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect.zero, style: .plain)
        tabel.rowHeight = scaleY(y: 60)
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
        
        getDatasAction(orderByType: "本月胜场")
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
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    //排行榜列表
    func getDatasAction(orderByType:String) -> () {
        
        let url = kProfessorWinRateListPort;
        var parameters = [String:Any]()
        parameters["recommendType"] = DataService.hintsTypeStringFormType(type: type!)//心水类别
        //排序方式 月胜场(toMonthWins)、连胜场数(toContWinCount)
        parameters["orderByType"]   = DataService.hintsOrderTypeFromName(name: orderByType)
        parameters["pageNum"]   = (1)//需要显示的页数
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr.removeAll()
            
            let responseObject = httpModel.data?["list"] as? NSArray
            print(responseObject ?? "")
            
            let arr:[PaiHangBangModel] = PaiHangBangModel.mj_objectArray(withKeyValuesArray: responseObject) as! [PaiHangBangModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (error:Error) in
            print(error)
        }
        
    }
    

    // MARK: 代理和协议
}

extension PaiHangBangChildVC:UITableViewDelegate,UITableViewDataSource,SixHeadViewDelegate{
    
    func btnClick(_ index: Int, btn: UIButton) {
        getDatasAction(orderByType: btn.currentTitle!)
    }
    
    func click(cell: ZhuangjiaCell, btn: UIButton) {
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
        let cell = PaiHangBangCell.cellWithTableView(tableView)
        cell.refresh(model: dataArr[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
