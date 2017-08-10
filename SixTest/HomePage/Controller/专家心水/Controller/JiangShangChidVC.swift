//
//  JiangShangChidVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/30.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class JiangShangChidVC: UIViewController {

    var type:KHintsType?
    var currentTitle:String = "本月胜场"
    var yearString:String = "2017"
    var monthString:String = "05"
    
    fileprivate var dataArr = [PaiHangBangModel]()
    // MARK: 懒加载
    lazy var headView:SixHeadView = {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 40))
        let headView = SixHeadView(frame: frame, titles: ["本月胜场","本月连胜榜"])
        headView.delegate = self
        return headView
    }()
    
    lazy var timeView:UIView = {
        let timeView = UIView()
        return timeView
    }()
    
    lazy var timeButton:UIButton = {
        let timeButton = UIButton(type: UIButtonType.custom)
        timeButton.addTarget(self, action: #selector(timeButtonClick), for: UIControlEvents.touchUpInside)
        timeButton.setTitle("\(self.yearString)-\(self.monthString)", for: UIControlState.normal)
        timeButton.backgroundColor = UIColor.red
        timeButton.titleLabel?.font = adoptedFont(fontSize: 12)
        return timeButton
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
        
        getDatasAction(orderByType: currentTitle, year: yearString, month: monthString)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        timeView.frame = CGRect(x: 0, y: headView.height, width: ScreenWidth, height: scaleY(y: 25))
        timeView.addTopLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        timeView.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        timeButton.frame = CGRect(x: ScreenWidth - scaleX(x: 55) - scaleX(x: 20), y: scaleY(y: 2.5), width: scaleX(x: 55), height: scaleY(y: 20))
        
        let y = timeView.bottom
        myTabelView.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: view.height - y)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        
        view.addSubview(headView)
        view.addSubview(timeView)
        timeView.addSubview(timeButton)
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    func timeButtonClick(btn:UIButton) -> () {
        let race = CGRect(x: 0, y: 0, width: ScreenWidth, height: view.height)
        let pickView = SelectPickView(race:race,type: .pickViewTypeDate, dataArr:[], midShowString: "请选择日期")
        pickView.rightBlock = {
            [weak self]
            (object : Any) in
    
            let timeStr = object as? String ?? ""
    
            let fitstSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 0)
            let fitstEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 4)
            let yearStr = timeStr.substring(with: fitstSubIndex..<fitstEndIndex)
            
            let secondSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 5)
            let secondEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 7)
            let monStr = timeStr.substring(with: secondSubIndex..<secondEndIndex)
            
            btn.setTitle("\(yearStr)-\(monStr)", for: UIControlState.normal)
            self?.yearString  = yearStr
            self?.monthString = monStr
            self?.getDatasAction(orderByType: self?.currentTitle ?? "", year: self?.yearString ?? "", month: self?.monthString ?? "")
 

        }
        
        view.addSubview(pickView)
    }
    
    // MARK: HTTP请求
    //排行榜列表
    func getDatasAction(orderByType:String,year:String,month:String) -> () {
        
        let url = kProfessionalHintsRewardListPort;
        var parameters = [String:Any]()
        parameters["recommendType"] = DataService.hintsTypeStringFormType(type: type!)//心水类别
        //排序方式 月胜场(toMonthWins)、连胜场数(toContWinCount)
        parameters["orderByType"]   = DataService.hintsOrderTypeFromName(name: orderByType)
        parameters["pageNum"]   = (1)//需要显示的页数
        parameters["year"]      = yearString
        parameters["month"]     = monthString
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr.removeAll()
            
            let responseObject = httpModel.data?["list"] as? NSArray
            if responseObject?.count == 0{
                 AlertViewUtil.alertShow(message: "暂时没有数据", controller: nil, confirmTitle: "确定")
            }
            print(responseObject ?? "")
            
            let arr:[PaiHangBangModel] = PaiHangBangModel.mj_objectArray(withKeyValuesArray: responseObject) as! [PaiHangBangModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    
    // MARK: 代理和协议
}

extension JiangShangChidVC:UITableViewDelegate,UITableViewDataSource,SixHeadViewDelegate{
    
    func btnClick(_ index: Int, btn: UIButton) {
        currentTitle = btn.currentTitle ?? ""
        getDatasAction(orderByType: currentTitle, year: yearString, month: monthString)
    }
    
    func click(cell: ZhuangjiaCell, btn: UIButton) {
        if !User.sharedInstance().isLogin {
            let vc = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
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
