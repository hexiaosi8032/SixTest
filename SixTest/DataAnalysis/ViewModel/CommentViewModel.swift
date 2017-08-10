//
//  CommentViewModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJRefresh

class CommentViewModel: NSObject {

    var pageNum:Int = 1
    var idStr:String = ""
    var superVC:UIViewController?
    var dataArr = [CommentFrameModel]()
    var tabelView:UITableView?
    var inputButton:UIButton?
    var inputView:XSInputView?
    var isClickTag:Int = 1000
    var parentTopicId:String?
    var replyTo:String?
    
    //回复-主回复查询
    func loadMainReplyData() -> () {
        
        let url = kReplyMainQuery;
        var parameters = [String:Any]()
        parameters["type"] = "INFO"
        parameters["rootTopicId"] = idStr
        parameters["mainPageNum"] = pageNum
        parameters["mainPageSize"] = (6)
        parameters["childPageSize"] = (5)
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            guard let responseObject = httpModel.data as? NSDictionary
                else{
                    return
            }
            print(responseObject)
            if self?.pageNum == 1 {
                self?.dataArr.removeAll()
            }
            
            let arr:[ReplyListModel] = ReplyListModel.mj_objectArray(withKeyValuesArray: responseObject["list"]) as! [ReplyListModel]
            
            for replyListModel in arr{
                let model = CommentFrameModel()
                model.listModel = replyListModel
                self?.dataArr.append(model)
            }
            self?.tabelView?.reloadData()
            self?.tabelView?.mj_header.endRefreshing()
            self?.tabelView?.mj_footer.endRefreshing()
            self?.tabelView?.mj_footer.isHidden = (self?.dataArr.count == 0)
            if arr.count == 0 {
                self?.tabelView?.mj_footer.endRefreshingWithNoMoreData()
            }
            
        }) {
            [weak self]
            (httpModel:HttpModel) in
            self?.tabelView?.mj_header.endRefreshing()
            self?.tabelView?.mj_footer.endRefreshing()
            print(httpModel.message ?? "")
        }
        
    }
    
    //提交评论
    func saveReplyData() -> () {
        
        let url = kAPIGatewayPort;
        var parameters = [String:Any]()
        parameters["userName"] = User.sharedInstance().userName
        parameters["type"] = "INFO"
        parameters["rootTopicId"] = idStr
        parameters["content"] = inputView?.text
        parameters["operationType"] = kAPIReplyCommentTopic
        //评论
        if isClickTag == 1000 {
            
        }
        //发布按钮
        else if  isClickTag == 1001{
            parameters["parentTopicId"] = parentTopicId!
        }
        //回复
        else{
            parameters["replyTo"] = replyTo!
            parameters["parentTopicId"] = parentTopicId!
        }
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            //登录后回调
            if httpModel.statusCode == "USER_KEY_EXPIRE"{
                self?.saveReplyData()
                return
            }
            
            guard let responseObject = httpModel.data as? NSDictionary
                else{
                    return
            }
            print(responseObject)
            
            self?.pageNum = 1
            self?.loadMainReplyData()
            self?.inputView?.text = nil
            self?.inputView?.resignFirstResponder()
            
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }

    
}

extension CommentViewModel:UITableViewDelegate,UITableViewDataSource,CommentCelldelegate,UITextViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentCell.cellWithTableView(tableView)
        cell.floorLabel.text = "\(indexPath.row + 1)楼"
        cell.model = dataArr[indexPath.row]
        cell.commentCelldelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArr[indexPath.row].cellH
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        inputView?.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        inputView?.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        inputButton?.isHidden = false
    }
    
    func click(cell: CommentCell?, view: AnyObject?) {
        guard let cell = cell,
              let view = view
        else {
            return
        }
        //得到当前点击按钮所在位置
        guard let indexPath = tabelView?.indexPath(for: cell),
              let model = dataArr[indexPath.row].listModel
            else {
            return
        }
        if !User.sharedInstance().isLogin {
            let vc = LoginViewController()
            superVC?.navigationController?.pushViewController(vc, animated: true)
            return
        }
        print("内容为\(model.reply?.content ?? "")")
        if view.isKind(of: UIButton.self) {
            print("点击了按钮")
            isClickTag = 1001
            parentTopicId = model.reply?.ID
            inputView?.becomeFirstResponder()
        }else if view.isKind(of: UILabel.self){
            if view.tag == 10 {
                print("点击了回复1")
                inputView?.becomeFirstResponder()
                isClickTag = 1002
                parentTopicId = model.childReplyList?[0].reply?.parentTopicId
                replyTo = model.childReplyList?[0].replyer?.ID
            }else if view.tag == 11{
                inputView?.becomeFirstResponder()
                parentTopicId = model.childReplyList?[1].reply?.parentTopicId
                replyTo = model.childReplyList?[1].replyer?.ID
                isClickTag = 1002
                print("点击了回复2")
            }else if view.tag == 12{
                let vc = CommentDetailVC()
                vc.rootTopicId = self.idStr
                vc.parentTopicId = model.reply?.ID
                vc.imgStr = model.replyerHeadPortraitFullPath
                vc.nameStr = model.replyer?.nickName
                vc.userRole = model.replyer?.userRole
                vc.content = model.reply?.content
                vc.foolStr = "\(indexPath.row)楼"
                vc.timeStr = model.displayReplyTime
                vc.replyType = "INFO"
                superVC?.navigationController?.pushViewController(vc, animated: true)
                print("点击了总")
            }
        }else if view.isKind(of: UIImageView.self){
            let vc = LookZhuangjiaVC()
            vc.userid = model.replyer?.ID
            vc.isShowAllCurrentList = true
            superVC?.navigationController?.pushViewController(vc, animated: true)
            print("点击了头像")
        }
        
    }
}

