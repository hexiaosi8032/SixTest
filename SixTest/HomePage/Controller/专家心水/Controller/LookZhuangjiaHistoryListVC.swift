//
//  LookZhuangjiaHistoryListVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//  查看专家历史推荐 子控制器

import UIKit
import MJExtension

class LookZhuangjiaHistoryListVC: UIViewController {

    var type:KHintsType?
    var userid:String?
    var superVC:LookZhuangjiaVC?
    
    fileprivate var dataArr = [ZhuangjiaCurrentHistoryModel]()
    // MARK: 懒加载
    lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect.zero, style: .plain)
        tabel.rowHeight = scaleY(y: 50)
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
        
        getDatasAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTabelView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(myTabelView)
    }
    
    func getTimeNo(timeStr:String) -> (String) {
        
        let fitstSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 0)
        let fitstEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 4)
        let yearStr         = timeStr.substring(with: fitstSubIndex..<fitstEndIndex)
        
        let secondSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 4)
        let secondEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 6)
        let monStr           = timeStr.substring(with: secondSubIndex..<secondEndIndex)
        
        let thirdSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 6)
        let thirdEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 8)
        let dayStr = timeStr.substring(with: thirdSubIndex..<thirdEndIndex)
        
        let noStr           = timeStr.substring(from: timeStr.index(timeStr.startIndex, offsetBy: 9))
        
        return "\(yearStr)年-\(monStr)月-\(dayStr)日 第\(noStr)期"
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    func getDatasAction() -> () {
        
        let url = kRecommendRecordHistoryListPort;
        var parameters = [String:Any]()
        parameters["recommendRecordType"] = DataService.hintsTypeStringFormType(type: type!)//心水类别
        parameters["userid"]    = userid
        parameters["pageNum"]   = (1)//需要显示的页数
        print(parameters)
 
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            print(httpModel.data ?? "")
            let responseObject = httpModel.data?["list"] as? NSArray
            
            let arr:[ZhuangjiaCurrentHistoryModel] = ZhuangjiaCurrentHistoryModel.mj_objectArray(withKeyValuesArray: responseObject) as! [ZhuangjiaCurrentHistoryModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
 
            
        }) { (error:Error) in
            print(error)
 
        }
        
    }
    // MARK: 代理和协议
}

extension LookZhuangjiaHistoryListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if dataArr.count == 0 {
            return nil
        }
        
        let customView = UIView()
        customView.backgroundColor = UIColor.white
        customView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 25))
        
        let label:UILabel = UILabel()
        label.frame = CGRect(x: scaleX(x: 20), y: 0, width: ScreenWidth - scaleX(x: 40), height:scaleY(y: 25))
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        label.textAlignment = .left
        label.font = adoptedFont(fontSize: 14)
        label.text = getTimeNo(timeStr: dataArr[section].publishDateNo ?? "")
        customView.addSubview(label)
        
        return customView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scaleY(y: 25)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ZhuanjiaHistoryCell.cellWithTableView(tableView)
        cell.model = dataArr[indexPath.section]
        cell.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = LookZhuangjiaHistoryCotentVC()
        vc.publishDateNo = dataArr[indexPath.section].publishDateNo
        vc.infoModel = superVC?.topView.model
        vc.contentModel = dataArr[indexPath.section]
        superVC?.navigationController?.pushViewController(vc, animated: true)
        
    }

}
