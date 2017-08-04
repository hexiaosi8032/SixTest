//
//  LookZhuangjiaNowView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/17.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LookZhuangjiaNowView: UIView {
    
    var type:KHintsType?
    // MARK: didSet
    var nextPublishDateNo:String? {
        didSet{
            
            let timeStr = nextPublishDateNo ?? ""
            
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
            
            nextPublishDateNo = "\(yearStr)年-\(monStr)月-\(dayStr)日 第\(noStr)期"
            contentView.nextPublishDateNo = nextPublishDateNo
        }
    }
    
    var dataArr:[ZhuangjiaCurrentHistoryModel]? {
        didSet{
            myTabelView.reloadData()
            
            guard let type = type else {
                return
            }
            
            for model in dataArr! {
                if model.type == DataService.hintsTypeStringFormType(type: type){
                    contentView.currentModel = model
                }
            }
 
        }
    }
    
    var superVC:LookZhuangjiaVC?
    
    // MARK: 懒加载
    lazy var myTabelView:UITableView = {
        [weak self] in
        let tabel = UITableView(frame:CGRect.zero, style: .plain)
        tabel.rowHeight = scaleY(y: 55)
        tabel.tableFooterView = UIView(frame: CGRect.zero)
        tabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tabel.delegate = self
        tabel.dataSource = self
        return tabel
    }()
    
    lazy var contentView:LookZhuangjiaCurrentConetView = {
        let contentView = LookZhuangjiaCurrentConetView()
        return contentView
    }()
    
    // MARK: 初始化和生命周期
    init(isShowAllCurrentList:Bool) {
        
        super.init(frame: CGRect.zero)
        
        if isShowAllCurrentList {
            addSubview(myTabelView)
        }else{
            addSubview(contentView)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTabelView.frame = bounds
        
        contentView.frame = bounds
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    
    // MARK: Target方法
 
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}

extension LookZhuangjiaNowView:UITableViewDelegate,UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customView = UIView()
        customView.backgroundColor = UIColor.white
        customView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 25))
        
        let label:UILabel = UILabel()
        label.frame = CGRect(x: scaleX(x: 20), y: 0, width: ScreenWidth - scaleX(x: 40), height:scaleY(y: 25))
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        label.textAlignment = .left
        label.font = adoptedFont(fontSize: 14)
        label.text = nextPublishDateNo
        
        customView.addTopLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        customView.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 0.5)
        customView.addSubview(label)
        
        return customView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return scaleY(y: 25)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LookZhuangjiaNowCell.cellWithTableView(tableView)
        cell.model = dataArr?[indexPath.row]
//        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColorFromRGB(rgbValue: kBackGroundColor) : UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LookZhuangjiaCurrentContenVC()
        vc.nextPublishDateNo = nextPublishDateNo
        vc.infoModel = superVC?.topView.model
        vc.currentModel = dataArr?[indexPath.row]
        superVC?.navigationController?.pushViewController(vc, animated: true)
  
    }
}

