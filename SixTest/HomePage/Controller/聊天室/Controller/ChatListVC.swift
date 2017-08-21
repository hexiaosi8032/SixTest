//
//  ChatListVC.swift
//  SixTest
//
//  Created by hxs on 2017/8/18.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import Hyphenate
import MBProgressHUD

class ChatListVC: UIViewController {
    
    fileprivate var dataArr = [ChatListModel]()
    
    // MARK: 懒加载
    fileprivate lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), style: .plain)
        tabel.rowHeight = scaleY(y: 70)
        tabel.tableFooterView = UIView(frame: CGRect.zero)
        tabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tabel.delegate = self
        tabel.dataSource = self
        
        tabel.register(UINib(nibName: "ChatListCell", bundle: nil), forCellReuseIdentifier: "ChatListCell")
        return tabel
        }()
    
    lazy var errorView:SixErrorView = {
        [weak self] in
        let errorView:SixErrorView = SixErrorView(frame: self?.view.bounds ?? CGRect.zero, block: {
            self?.loadData()
        })
        return errorView
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
        
        title = "聊天室列表"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(myTabelView)
    }
    
    // MARK: Target方法
    
    //日期控件的点击
    
    // MARK: HTTP请求
    func loadData() -> () {
        
        let url = kChatroomListFetchPort;
//        var parameters = [:]
        print(errorView)
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: [:], success: {
            [weak self]
            (httpModel:HttpModel) in
            
            let responseObject = httpModel.data as? NSArray ?? []
            
            let arr:[ChatListModel] = ChatListModel.mj_objectArray(withKeyValuesArray: responseObject) as! [ChatListModel]
            self?.dataArr += arr
            self?.myTabelView.reloadData()
            self?.errorView.removeFromSuperview()
        }) {
            [weak self]
            (httpModel:HttpModel) in
            
            self?.view.addSubview(self?.errorView ?? UIView())
            print(httpModel.message ?? "")
        }
        
    }
    
    // MARK: 代理和协议
    
}

extension ChatListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell") as! ChatListCell
        let model = dataArr[indexPath.row]
        cell.titleLabel.text = model.name
        cell.adminLabel.text = "管理员:\(model.owner ?? "")"
        cell.peopelCountLabel.text = "当前人数:\(model.userCount ?? "")"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !User.sharedInstance().isLogin{
            let loginVC = LoginViewController()
            navigationController?.pushViewController(loginVC, animated: true)
            return
        }
        
        let hud = MBProgressHUD.showAdded(to:UIApplication.shared.keyWindow!, animated: true)
        hud.label.text = "正在登录..."
        EMClient.shared().login(withUsername: User.sharedInstance().userName, password: User.sharedInstance().userName) { (name:String?, error:EMError?) in
            if error == nil{
                let vc = ChatViewController(conversationChatter: self.dataArr[indexPath.row].ID ?? "", conversationType: EMConversationTypeChatRoom)
                vc?.title = self.dataArr[indexPath.row].name ?? ""
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                AlertViewUtil.alertShow(message: "聊天室登录失败,请稍后再试", controller: nil, confirmTitle: "确定")
            }
            
            hud.hide(animated: true)
        }
        
    }
}
