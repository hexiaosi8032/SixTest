//
//  SearchZhuangjiaCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol SearchZhuangjiaCelldelegate : NSObjectProtocol {
    func click(cell:SearchZhuangjiaCell,btn:UIButton)
}

class SearchZhuangjiaCell: UITableViewCell {

    var mydelegate:SearchZhuangjiaCelldelegate?
    
    // MARK: didSet
    var model:SearchZhuangjiaModel? {
        didSet{
            let url:URL = URL(string: model?.headPortrait ?? "")!
            let image:UIImage = UIImage(named: "默认头像")!
            imgView.sd_setImage(with: url, placeholderImage: image)
            userNameLabel.text = model?.nickName
            
            totolLabel.text = "总心水: \(model?.totalRecommend ?? "")"
            totolLabel.attributedText =  totolLabel.addContentColor(title: (totolLabel.text ?? ""), changeTitle: (model?.totalRecommend ?? ""), changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
            attentionBtn.isEnabled = model?.followed != "Y"
            
        }
 
    }
    
    // MARK: 懒加载
    lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var userNameLabel:UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        userNameLabel.font = adoptedFont(fontSize: 15)
        return userNameLabel
    }()
    
    lazy var totolLabel:UILabel = {
        let totolLabel = UILabel()
        totolLabel.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        totolLabel.font = adoptedFont(fontSize: 14)
        return totolLabel
    }()
    
    lazy var attentionBtn:UIButton = {
        let attentionBtn = UIButton(type: .custom)
        attentionBtn.addTarget(self, action: #selector(attentionBtnClick), for: .touchUpInside)
        
        attentionBtn.setImage(UIImage(named: "专家_加关注"), for: .normal)
        attentionBtn.setImage(UIImage(named: "专家_已关注"), for: .disabled)
        return attentionBtn
    }()
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    
    // MARK: 初始化和生命周期
    static let cellID = "SearchZhuangjiaCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> SearchZhuangjiaCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = SearchZhuangjiaCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! SearchZhuangjiaCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        contentView.addSubview(imgView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(totolLabel)
        contentView.addSubview(attentionBtn)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imgWH = scaleX(x: 33)
        imgView.frame = CGRect(x: scaleX(x: 30), y: (height - imgWH) / 2, width: imgWH, height: imgWH)
        imgView.layer.cornerRadius = imgView.width / 2
        imgView.layer.masksToBounds = true
        
        let labelH = scaleY(y: 15)
        userNameLabel.frame = CGRect(x: imgView.right + scaleX(x: 15), y: (height - labelH) / 2, width: scaleX(x: 90), height: labelH)
        totolLabel.frame = CGRect(x: userNameLabel.right + scaleX(x: 20), y: (height - labelH) / 2, width: scaleX(x: 90), height: labelH)
        
        let attentionBtnW = scaleX(x: 25)
        attentionBtn.frame = CGRect(x: width - scaleX(x: 20) - attentionBtnW, y: (height - attentionBtnW) / 2, width: attentionBtnW, height: attentionBtnW)
        
        line.frame = CGRect(x: 0, y: height - 0.5, width: width, height: 0.5)
    }
    
    // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .center
        return label
    }
    
    // MARK: Target方法
    func attentionBtnClick(btn:UIButton) -> () {
        mydelegate?.click(cell: self, btn: btn)
    }
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议


}
