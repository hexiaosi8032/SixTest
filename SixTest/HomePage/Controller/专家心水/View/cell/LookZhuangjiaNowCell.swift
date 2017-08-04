//
//  LookZhuangjiaNowCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/17.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LookZhuangjiaNowCell: UITableViewCell {
    
    // MARK: didSet
    var model:ZhuangjiaCurrentHistoryModel? {
        didSet{
         
            typeLabel.text = DataService.hintsFromCode(code: model?.type ?? "")
            recentWinLabel.text = "(最近连胜\(model?.recentWinCount ?? ""))"
            titleLabel.text = model?.title

            victoryLabel.text = "月胜负 (\(model?.winCount ?? "")/\(model?.lostCount ?? ""))"
            lookLabel.text = "查看数 \(model?.hits ?? "")"
            timeLabel.text = model?.dateStr
            
            recentWinLabel.attributedText = recentWinLabel.addContentColor(title: recentWinLabel.text ?? "", changeTitle: model?.recentWinCount ?? "", changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
            
        }
        
    }
    
    // MARK: 懒加载
    //类型
    lazy var typeLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    //标题
    lazy var titleLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        return label
    }()
    
    //连胜
    lazy var recentWinLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .center
        return label
    }()
    
    //胜负
    lazy var victoryLabel:UILabel = {
        let label = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        return label
    }()
    
    //查看数
    lazy var lookLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        label.textAlignment = .center
        return label
    }()
    
    //时间
    lazy var timeLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 12, color: UIColorFromRGB(rgbValue: kLightGrayFontColor))
        label.textAlignment = .center
        return label
    }()
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    
    // MARK: 初始化和生命周期
    static let cellID = "LookZhuangjiaNowCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> LookZhuangjiaNowCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = LookZhuangjiaNowCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            tableView.separatorStyle = .none
        }
        
        return cell as! LookZhuangjiaNowCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(typeLabel)
        addSubview(titleLabel)
        addSubview(recentWinLabel)
        addSubview(victoryLabel)
        addSubview(lookLabel)
        addSubview(timeLabel)
        addSubview(line)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
        let topY = scaleY(y: 10)
        let topH = scaleY(y: 15)
        let x    =  scaleX(x: 20)
        let margin = scaleX(x: 15)
        typeLabel.frame = CGRect(x: x, y: topY, width: scaleX(x: 70), height: topH)
        titleLabel.frame = CGRect(x: typeLabel.right + margin, y: topY, width: scaleX(x: 250), height: topH)
        
        let bottomY = typeLabel.bottom + scaleY(y: 10)
        let bottomW = scaleX(x: 70)
        let bottomH = scaleY(y: 12)
        recentWinLabel.frame = CGRect(x: x, y: bottomY, width: typeLabel.width, height: bottomH)
        victoryLabel.frame = CGRect(x: recentWinLabel.right + margin, y: bottomY, width: bottomW, height: bottomH)
        lookLabel.frame = CGRect(x: victoryLabel.right + margin, y: bottomY, width: bottomW, height: bottomH)
        timeLabel.frame = CGRect(x: lookLabel.right + margin, y: bottomY, width: bottomW, height: bottomH)
        line.frame = CGRect(x: 0, y:height - 0.5 , width: width, height: 0.5)
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
