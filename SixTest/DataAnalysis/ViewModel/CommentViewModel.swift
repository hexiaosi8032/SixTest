//
//  CommentViewModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class CommentViewModel: NSObject {

    var pageNum:Int = 1
    var idStr:String = ""
    var superVC:UIViewController?
    var dataArr = [CommentFrameModel]()
    var tabelView:UITableView?
    
    var inputView:XSInputView?
    
    //回复-主回复查询
    func loadMainReplyData() -> () {
        
        let url = kReplyMainQuery;
        var parameters = [String:Any]()
        parameters["type"] = "RECOMMEND"
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
            let arr:[ReplyListModel] = ReplyListModel.mj_objectArray(withKeyValuesArray: responseObject["list"]) as! [ReplyListModel]
            for replyListModel in arr{
                let model = CommentFrameModel()
                model.listModel = replyListModel
                self?.dataArr.append(model)
                self?.tabelView?.reloadData()
            }
            
        }) { (error:Error) in
            print(error)
        }
        
    }
    
}

extension CommentViewModel:UITableViewDelegate,UITableViewDataSource,CommentCelldelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentCell.cellWithTableView(tableView)
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
    
    func click(cell: CommentCell, view: AnyObject) {
        //得到当前点击按钮所在位置
        guard let indexPath = tabelView?.indexPath(for: cell),
              let model = dataArr[indexPath.row].listModel
            else {
            return
        }
        print("内容为\(model.reply?.content ?? "")")
        if view.isKind(of: UIButton.self) {
            print("点击了按钮")
            inputView?.becomeFirstResponder()
        }else if view.isKind(of: UILabel.self){
            if view.tag == 10 {
                print("点击了回复1")
            }else if view.tag == 11{
                print("点击了回复2")
            }else if view.tag == 12{
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

