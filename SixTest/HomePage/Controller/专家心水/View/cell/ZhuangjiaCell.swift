//
//  ZhuangjiaCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol ZhuangjiaCelldelegate : NSObjectProtocol {
    func click(cell:ZhuangjiaCell,btn:UIButton)
}

class ZhuangjiaCell: UITableViewCell {

    var mydelegate:ZhuangjiaCelldelegate?
    // MARK: didSet
    var model:ZhuangjiaListModel? {
        didSet{
   
            let url:URL = URL(string: model?.imageUrl ?? "")!
            let image:UIImage = UIImage(named: "默认头像")!
            headIcon.sd_setImage(with: url, for: .normal, placeholderImage: image)
        
            userNameLabel.text = model?.nickName
            titleLabel.text = model?.title
            victoryLabel.text = "月胜负 (\(model?.winCount ?? "")/\(model?.lostCount ?? ""))"
            lookLabel.text = "查看数 \(model?.hits ?? "")"
            timeLabel.text = model?.dateStr
            
        }
    }
    
    // MARK: 懒加载
    lazy var headIcon:UIButton = {
        let headIcon = UIButton(type: UIButtonType.custom)
        headIcon.addTarget(self, action: #selector(iconClick), for: UIControlEvents.touchUpInside)
        return headIcon
    }()
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    lazy var userNameLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel:UILabel = {
        let label = self.addLabel(fontSize: 16, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .left
        return label
    }()
    
    //胜负
    lazy var victoryLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        return label
    }()
    
    //查看数
    lazy var lookLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        return label
    }()
    
    //时间
    lazy var timeLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        return label
    }()
    
    lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        return lineView
    }()
    
    // MARK: 初始化和生命周期
    static let cellID = "ZhuangjiaCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> ZhuangjiaCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = ZhuangjiaCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            tableView.separatorStyle = .none
        }
        
        return cell as! ZhuangjiaCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(headIcon)
        addSubview(userNameLabel)
        addSubview(line)
        
        addSubview(titleLabel)
        addSubview(victoryLabel)
        addSubview(lookLabel)
        addSubview(timeLabel)
        
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        headIcon.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 5), width: scaleX(x: 50), height: scaleX(x: 50))
        headIcon.layer.cornerRadius = headIcon.width / 2
        headIcon.layer.masksToBounds = true
        
        userNameLabel.frame = CGRect(x: scaleX(x: 5) , y: headIcon.bottom + scaleY(y: 2), width: scaleX(x: 70), height: scaleY(y: 15))
        line.frame = CGRect(x: headIcon.right + scaleX(x: 15), y: scaleY(y: 10), width: 1, height: scaleY(y: 60))
        titleLabel.frame = CGRect(x: line.right + scaleX(x: 15), y: scaleY(y: 15), width: scaleX(x: 260), height: scaleY(y: 20))
        
        let bottomW = scaleX(x: 80)
        let bottomH = scaleY(y: 15)
        let bottomY = titleLabel.bottom + scaleY(y: 20)
        victoryLabel.frame = CGRect(x: titleLabel.x, y: bottomY, width: bottomW, height: bottomH)
        lookLabel.frame = CGRect(x: victoryLabel.right + scaleX(x: 10), y: bottomY, width: bottomW, height: bottomH)
        timeLabel.frame = CGRect(x: lookLabel.right + scaleX(x: 10), y: bottomY, width: bottomW, height: bottomH)
        
        lineView.frame = CGRect(x: 0, y: height - scaleY(y: 10), width: ScreenWidth, height: scaleY(y: 10))
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
    func iconClick(btn:UIButton) -> () {
        mydelegate?.click(cell: self, btn: btn)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
