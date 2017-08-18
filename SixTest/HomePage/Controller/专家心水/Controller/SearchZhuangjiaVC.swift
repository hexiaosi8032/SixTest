//
//  SearchZhuangjiaVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//  搜索专家

import UIKit
import MJExtension

class SearchZhuangjiaVC: UIViewController {

    var nickName:String?
    var pageNum:Int = 1
    
    fileprivate var dataArr = [SearchZhuangjiaModel]()
    // MARK: 懒加载
    lazy var searchView:UIView = {
        let searchView = UIView()
        searchView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        return searchView
    }()
    
    lazy var searchTextFiled:UITextField = {
        let searchTextFiled = UITextField()
        searchTextFiled.placeholder = "请输入专家名称"
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getSearchDatasAction(keyword: searchTextFiled.text ?? "")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: scaleY(y: 50))
        searchTextFiled.frame = CGRect(x: scaleX(x: 10), y: scaleY(y: 10), width: scaleX(x: 355), height: scaleY(y: 30))
        let y = 64 + searchView.height
        myTabelView.frame = CGRect(x: 0, y:  y, width: ScreenWidth, height: ScreenHeight - y)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "搜索专家"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(searchView)
        searchView.addSubview(searchTextFiled)
        view.addSubview(myTabelView)
        nickName = ""
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    //获取搜索列表
    func getSearchDatasAction(keyword:String) -> () {
        
        let url = kSearchExpertListPort;
        var parameters         = [String:Any]()
        parameters["keyword"]  = keyword//用户昵称
        parameters["userName"] = User.sharedInstance().userName//当前登录用户
        parameters["pageNum"]  = (pageNum)
        parameters["pageSize"] = (10)
 
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            guard let dic = httpModel.data as? NSDictionary
                else{
                    return
            }
            
            self?.dataArr.removeAll()
            
            let responseObject = dic["list"] as? NSArray
            print(responseObject ?? "")
            
            let arr:[SearchZhuangjiaModel] = SearchZhuangjiaModel.mj_objectArray(withKeyValuesArray: responseObject) as! [SearchZhuangjiaModel]
 
            self?.dataArr += arr
            self?.myTabelView.reloadData()
    
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }

    //加关注
    func getAttentionDatasAction(row:Int) -> () {
        
        
        let model:SearchZhuangjiaModel = dataArr[row]
        let url = kFollowExpertListPort;
        var parameters          = [String:Any]()
        parameters["userName"]  = User.sharedInstance().userName//当前登录用户
        parameters["toUserId"]  = model.ID
        parameters["type"]      = "add"//只能关注不能取消
 
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr[row].followed = "Y"
            self?.myTabelView.reloadData()
            AlertViewUtil.alertShow(message: "关注成功", controller: nil, confirmTitle: "提示")
 
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议

}

extension SearchZhuangjiaVC:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SearchZhuangjiaCelldelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SearchZhuangjiaCell.cellWithTableView(tableView)
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
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let vc = LookZhuangjiaVC()
        vc.userid = dataArr[indexPath.row].ID
        navigationController?.pushViewController(vc, animated: true)
    }

    func click(cell: SearchZhuangjiaCell, btn: UIButton) {
        //得到当前点击按钮所在位置
        let indexPath = myTabelView.indexPath(for: cell)
        getAttentionDatasAction(row: indexPath?.row ?? 0)
        print(indexPath?.row ?? 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getSearchDatasAction(keyword: textField.text ?? "")
        return true
    }
    
    
}
