//
//  HintsBBSSearchVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/22.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HintsBBSSearchVC: UIViewController {

    fileprivate var dataArr = [HintsBBSModel]()
    // MARK: 懒加载
    lazy var searchView:UIView = {
        let searchView = UIView()
        searchView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        return searchView
    }()
    
    lazy var searchTextFiled:UITextField = {
        let searchTextFiled = UITextField()
        searchTextFiled.placeholder = "请输入用户昵称"
        searchTextFiled.font = adoptedFont(fontSize: 14)
        searchTextFiled.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        searchTextFiled.borderStyle = .roundedRect
        searchTextFiled.returnKeyType = .search
        searchTextFiled.delegate = self
        searchTextFiled.clearButtonMode = .always
        return searchTextFiled
    }()
    
    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect.zero, style: .plain)
        tabel.rowHeight = scaleY(y: 51)
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
        
        searchView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: scaleY(y: 50))
        searchTextFiled.frame = CGRect(x: scaleX(x: 10), y: scaleY(y: 10), width: scaleX(x: 355), height: scaleY(y: 30))
        let y = searchView.bottom
        myTabelView.frame = CGRect(x: 0, y:  y, width: ScreenWidth, height: ScreenHeight - y)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "搜索帖子"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(searchView)
        searchView.addSubview(searchTextFiled)
        view.addSubview(myTabelView)
        
        getDatasAction(keyWords: "")
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    //搜索帖子
    func getDatasAction(keyWords:String) -> () {
        
        let url = kHintsBBSTopicPort
        var parameters = [String:Any]()
        parameters["orderType"] = "newest"//newest:默认排序  upvote：按照点赞数排序  hits：按照浏览数排序
        parameters["pageNum"] = (1)//第几页
        parameters["pageSize"] = (15)//每页的数量
        parameters["keyWords"] = keyWords
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            
            [weak self]
            (httpModel:HttpModel) in
            
            guard let dic = httpModel.data as? NSDictionary
                else{
                    return
            }
            
            self?.dataArr.removeAll()
            
            let responseObject = dic["topicList"] as? NSArray
            let arr:[HintsBBSModel] = HintsBBSModel.mj_objectArray(withKeyValuesArray: responseObject) as! [HintsBBSModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    // MARK: 代理和协议

}

extension HintsBBSSearchVC:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HintsBBSCell.cellWithTableView(tableView)
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = HintsBBSContentVC()
        vc.userId = dataArr[indexPath.row].userId ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getDatasAction(keyWords: textField.text ?? "")
        return true
    }
    
    
}

