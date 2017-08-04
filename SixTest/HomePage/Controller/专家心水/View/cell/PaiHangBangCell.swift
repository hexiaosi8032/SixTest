//
//  PaiHangBangCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/28.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class PaiHangBangCell: UITableViewCell {
    
    // MARK: didSet
    var model:PaiHangBangModel? {
        didSet{
            
        }
    }
    
    // MARK: 懒加载
    lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    lazy var iconLabel: UILabel = {
        let iconLabel:UILabel = self.addLabel(fontSize: 17, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        iconLabel.textAlignment = .center
        return iconLabel
    }()
    
    lazy var headIconView: UIImageView = {
        let headIconView = UIImageView()
        return headIconView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return titleLabel
    }()
    
    lazy var sumLabel: UILabel = {
        let sumLabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return sumLabel
    }()
    
    lazy var winLabel: UILabel = {
        let winLabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return winLabel
    }()
    
    lazy var lianWinLabel: UILabel = {
        let lianWinLabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return lianWinLabel
    }()
    
    lazy var percentageLabel: UILabel = {
        let percentageLabel:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        percentageLabel.textAlignment = .right
        percentageLabel.textColor = UIColorFromRGB(rgbValue: kMainThemeColor)
        return percentageLabel
    }()
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    // MARK: 初始化和生命周期
    static let cellID = "PaiHangBangCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> PaiHangBangCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = PaiHangBangCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! PaiHangBangCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(iconLabel)
        contentView.addSubview(headIconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sumLabel)
        contentView.addSubview(winLabel)
        contentView.addSubview(lianWinLabel)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //60
        iconView.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 10), width: scaleX(x: 30), height: scaleY(y: 40))
        iconLabel.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 10), width: scaleX(x: 30), height: scaleY(y: 40))
        let iconWH = scaleX(x: 50)
        headIconView.frame = CGRect(x: iconView.right + scaleX(x: 15), y: (height - iconWH) / 2, width: iconWH, height: iconWH)
        headIconView.layer.cornerRadius = headIconView.width / 2
        headIconView.layer.masksToBounds = true
        
        titleLabel.frame = CGRect(x: headIconView.right + scaleX(x: 10), y: scaleY(y: 15), width: scaleX(x: 120), height: scaleY(y: 15))
        sumLabel.frame = CGRect(x: titleLabel.x, y: titleLabel.bottom + scaleY(y: 10), width: scaleX(x: 40), height: scaleY(y: 10))
        winLabel.frame = CGRect(x:sumLabel.right + scaleX(x: 10), y: titleLabel.bottom + scaleY(y: 10), width: scaleX(x: 60), height: scaleY(y: 10))
        lianWinLabel.frame = CGRect(x: winLabel.right + scaleX(x: 10), y: titleLabel.bottom + scaleY(y: 10), width: scaleX(x: 70), height: scaleY(y: 10))
        percentageLabel.frame = CGRect(x: width - scaleX(x: 15) - scaleX(x: 120), y: scaleY(y: 15), width: scaleX(x: 120), height: scaleY(y: 15))
        line.frame = CGRect(x: 0, y: height - 0.5, width: width, height: 0.5)
    }
    
     // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        return label
    }
    
    func refresh(model:PaiHangBangModel,indexPath:IndexPath) -> () {
        
        if indexPath.row > 2 {
            iconLabel.isHidden = false
            iconView.isHidden = true
        }else{
            iconLabel.isHidden = true
            iconView.isHidden  = false
        }
        
        if indexPath.row == 0 {
            iconView.image = UIImage(named: "第一名")
        }
        
        else if indexPath.row == 1 {
            iconView.image = UIImage(named: "第二名")
        }
        
        else if indexPath.row == 2 {
            iconView.image = UIImage(named: "第三名")
        }
        
        headIconView.sd_setImage(with: URL(string: model.imageUrl ?? ""), placeholderImage: UIImage(named: "默认头像"))
        iconLabel.text = "\(indexPath.row)"
        titleLabel.text = model.nickName ?? ""
        sumLabel.text = "总:\(model.totalCount ?? "")"
        winLabel.text = "胜负:\(model.winCount ?? "")/\(model.lostCount ?? "")"
        lianWinLabel.text = "最大连胜:\(model.recentWinCount ?? "")"
    
        if (model.winPercentage != nil) {
            percentageLabel.text = model.winPercentage
        }else{
            percentageLabel.text = "\(model.reward ?? "")金币"
        }
        
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
