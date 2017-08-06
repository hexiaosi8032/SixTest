//
//  HistoryVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HistoryVC: UIViewController {

    fileprivate var dataArr = [HistoryModel]()
    private var nowTimeString:String = "2017"
    
    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), style: .plain)
        tabel.rowHeight = scaleY(y: 70)
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
        
        getDatasAction(timeString: nowTimeString)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        
        title = "历史记录"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let timeSelectItem = UIBarButtonItem.itemWithTarget(target: self, action: #selector(itemClick), title: "2017", titleColor: UIColorFromRGB(rgbValue: kWhiteColor))
        timeSelectItem.customView?.layer.borderColor = UIColorFromRGB(rgbValue: kHalfWhiteColor).cgColor
        timeSelectItem.customView?.layer.borderWidth = 1.0;
        timeSelectItem.customView?.frame = CGRect(x: 0, y: 0, width: (timeSelectItem.customView?.frame.width)! + 6, height: (timeSelectItem.customView?.frame.height)! - 8)
        navigationItem.rightBarButtonItem = timeSelectItem;
        
        nowTimeString = "\(DataService.getCurrentYear())"
        
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    
    //日期控件的点击
    func itemClick(btn:UIButton) -> () {
        let titles =  DataService.getHistoryYears(firstYear: DataService.getCurrentYear())
        let race = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
        let pickView = SelectPickView(race:race,type: .pickViewTypeNormal, dataArr:titles, midShowString: "请选择年份")
        pickView.rightBlock = {
            (object : Any) in
            self.getDatasAction(timeString: object as! String)
            btn.setTitle(object as? String, for: .normal)
        }
        
        view.addSubview(pickView)
    }
    
    // MARK: HTTP请求
    func getDatasAction(timeString:String) -> () {
        
        let url = kQueryHistoryRecordPort;
        var parameters = [String:Any]()
        parameters["publishDateNo"] = timeString
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr.removeAll()
            
            guard let responseObject = httpModel.data as? NSArray
                else{
                    self?.myTabelView.reloadData()
                    return
            }
            let arr:[HistoryModel] = HistoryModel.mj_objectArray(withKeyValuesArray: responseObject) as! [HistoryModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (error:Error) in
            print(error)
        }
        
    }
    
    // MARK: 代理和协议

}


extension HistoryVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryCell.cellWithTableView(tableView)
        cell.model = dataArr[indexPath.row]
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColorFromRGB(rgbValue: kBackGroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
