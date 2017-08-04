//
//  ZhuanjiaHistoryCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class ZhuanjiaHistoryCell: UITableViewCell {

    // MARK: didSet
    var model:ZhuangjiaCurrentHistoryModel? {
        didSet{
            winOrLoseLabel.backgroundColor = model?.isWin == "Y" ? UIColorFromRGB(rgbValue: kMainThemeColor) : UIColorFromRGB(rgbValue: kNGDGreenColor)
            winOrLoseLabel.text =  model?.isWin == "Y" ? "胜" : "负"

            titleLabel.text = model?.title
        }
    }
    // MARK: 懒加载
    //输赢
    lazy var winOrLoseLabel:UILabel = {
   
        let label:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kWhiteColor))
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 16, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()
    
    // MARK: 初始化和生命周期
    static let cellID = "ZhuangjiaCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> ZhuanjiaHistoryCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = ZhuanjiaHistoryCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            tableView.separatorStyle = .none
        }
        
        return cell as! ZhuanjiaHistoryCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        contentView.addSubview(winOrLoseLabel)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        winOrLoseLabel.frame = CGRect(x: scaleX(x: 13), y: scaleY(y: 13), width: scaleX(x: 26), height: scaleY(y: 26))
        winOrLoseLabel.layer.cornerRadius = 5
        winOrLoseLabel.layer.masksToBounds = true
        titleLabel.frame = CGRect(x: winOrLoseLabel.right + scaleX(x: 30), y: scaleY(y: 16), width: scaleX(x: 250), height: scaleY(y: 19))
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
