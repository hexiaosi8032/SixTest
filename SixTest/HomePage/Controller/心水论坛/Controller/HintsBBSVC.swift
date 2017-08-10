//
//  HintsBBSVC.swift
//  SixTest
//
//  Created by IMAC on 2017/6/22.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HintsBBSVC: UIViewController {
 
    fileprivate var dataArr = [HintsBBSModel]()
    // MARK: 懒加载
    lazy var headView:SixHeadView = {
        let frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: scaleY(y: 40))
        let headView = SixHeadView(frame: frame, titles: ["最新","最多查看","最多赞",])
        headView.delegate = self
        return headView
    }()
    
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
        
        getDatasAction(orderType: "newest")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let y = headView.bottom
        myTabelView.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: view.height - y)
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "心水论坛"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        let searchItem = UIBarButtonItem(image: UIImage(named:"搜索按钮")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchItemClick))
        
        let writeItem =  UIBarButtonItem(image: UIImage(named:"写帖按钮")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(writeItemClick))
        
        navigationItem.rightBarButtonItems = [searchItem,writeItem]
        
        view.addSubview(headView)
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    func searchItemClick() -> () {
        let vc = HintsBBSSearchVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func writeItemClick() -> () {
        let vc = HintsBBSWriteVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: HTTP请求
    //首页帖子
    func getDatasAction(orderType:String) -> () {
        
        let url = kHintsBBSTopicPort
        var parameters = [String:Any]()
        parameters["orderType"] = orderType//newest:默认排序  upvote：按照点赞数排序  hits：按照浏览数排序
        parameters["pageNum"] = (1)//第几页
        parameters["pageSize"] = (15)//每页的数量
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            
            [weak self]
            (httpModel:HttpModel) in
            
            self?.dataArr.removeAll()
            
            let responseObject = httpModel.data?["topicList"] as? NSArray
            let arr:[HintsBBSModel] = HintsBBSModel.mj_objectArray(withKeyValuesArray: responseObject) as! [HintsBBSModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议

}

extension HintsBBSVC:UITableViewDelegate,UITableViewDataSource,SixHeadViewDelegate{
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

    
    func btnClick(_ index: Int, btn: UIButton) {
        switch index {
        //最新
        case 0:
            getDatasAction(orderType: "newest")
            break
        //最多查看
        case 1:
            getDatasAction(orderType: "hits")
            break
        //最多赞
        case 2:
            getDatasAction(orderType: "upvote")
            break
        default:
            break
            
        }
    }
}
