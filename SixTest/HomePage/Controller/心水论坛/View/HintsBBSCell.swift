//
//  HintsBBSCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/23.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HintsBBSCell: UITableViewCell {
    
    // MARK: didSet
    var model:HintsBBSModel? {
        didSet{
            isTopLabel.text = model?.isTop == "1" ? "顶" : ""
            isEssenceLabel.text = model?.isEssence == "1" ? "精" : ""
            titleLabel.textColor = model?.isTop == "1" ? UIColorFromRGB(rgbValue: kNGDGoldenYellowColor) : UIColorFromRGB(rgbValue: kNGDBlackFontColor)
            
            let noStr:String = model?.publishNo ?? ""
            noLabel.text = noStr.substring(from: noStr.index(noStr.startIndex, offsetBy: 9))
            
            titleLabel.text = model?.title
            nickNameLabel.text = model?.nickName
            timeFromNowLabel.text = model?.timeFromNow
            upvoteLabel.text = model?.upvote
            hitsLabel.text = model?.hits
        }
        
    }
    
    // MARK: 懒加载
    //置顶
    lazy var isTopLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kWhiteColor))
        label.backgroundColor = UIColorFromRGB(rgbValue: kBlueColor)
        label.textAlignment = .center
        return label
    }()
    //精华
    lazy var isEssenceLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kWhiteColor))
        label.backgroundColor = UIColorFromRGB(rgbValue: kMainThemeColor)
        label.textAlignment = .center
        return label
    }()
    
    //标题
    lazy var titleLabel:UILabel = {
        let label = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
        return label
    }()
    
    //期数
    lazy var noLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kWhiteColor))
        label.backgroundColor = UIColorFromRGB(rgbValue: kNGDLightGrayFontColor)
        label.textAlignment = .center
        return label
    }()
    
    //昵称
    lazy var nickNameLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
        return label
    }()
    
    //时间
    lazy var timeFromNowLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
        return label
    }()
    
    //赞图标
    lazy var zanImgView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "点赞数")
        return img
    }()
    
    //点赞的数量
    lazy var upvoteLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
        return label
    }()
    
    //浏览图标
    lazy var hitsImgView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "已读数")
        return img
    }()
    
    //浏览数
    lazy var hitsLabel:UILabel = {
        let label = self.addLabel(fontSize: 11, color: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
        return label
    }()
    
    lazy var line:UIView = {
        let line:UIView = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line
    }()
    // MARK: 初始化和生命周期
    static let cellID = "HintsBBSCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> HintsBBSCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = HintsBBSCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! HintsBBSCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(isTopLabel)
        contentView.addSubview(isEssenceLabel)
        contentView.addSubview(noLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(timeFromNowLabel)
        contentView.addSubview(zanImgView)
        contentView.addSubview(upvoteLabel)
        contentView.addSubview(hitsImgView)
        contentView.addSubview(hitsLabel)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isTopLabel.isHidden = !(model?.isTop == "1")
        isEssenceLabel.isHidden = !(model?.isEssence == "1")
        
        noLabel.isHidden = !isTopLabel.isHidden
        nickNameLabel.isHidden = !isTopLabel.isHidden
        timeFromNowLabel.isHidden = !isTopLabel.isHidden
        zanImgView.isHidden = !isTopLabel.isHidden
        upvoteLabel.isHidden = !isTopLabel.isHidden
        hitsImgView.isHidden = !isTopLabel.isHidden
        hitsLabel.isHidden = !isTopLabel.isHidden
        
        line.frame = CGRect(x: 0, y: height - 0.5, width: width, height: 0.5)
        
        //顶
        if model?.isTop == "1" {
            isTopLabel.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 17), width: scaleX(x: 17), height: scaleY(y: 17))
            //精
            if model?.isEssence == "1" {
                isEssenceLabel.frame = CGRect(x: isTopLabel.right + scaleX(x: 10), y: scaleY(y: 17), width: scaleX(x: 17), height: scaleY(y: 17))
                titleLabel.frame = CGRect(x: isEssenceLabel.right + scaleX(x: 10), y: scaleY(y: 17), width: scaleX(x: 290), height: scaleY(y: 17))
            }else{
                titleLabel.frame = CGRect(x: isTopLabel.right + scaleX(x: 10), y: scaleY(y: 17), width: scaleX(x: 290), height: scaleY(y: 17))
            }
        }

        else{
            noLabel.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 10), width: scaleX(x: 30), height: scaleY(y: 17))
            //精
            if model?.isEssence == "1" {
                isEssenceLabel.frame = CGRect(x: noLabel.right + scaleX(x: 10), y: scaleY(y: 10), width: scaleX(x: 17), height: scaleY(y: 17))
                titleLabel.frame = CGRect(x: isEssenceLabel.right + scaleX(x: 10), y: scaleY(y: 10), width: scaleX(x: 290), height: scaleY(y: 17))
            }else{
                titleLabel.frame = CGRect(x: noLabel.right + scaleX(x: 10), y: scaleY(y: 10), width: scaleX(x: 290), height: scaleY(y: 17))
            }
            
            let bottomW = scaleX(x: 60)
            let bottomY = titleLabel.bottom + scaleY(y: 7)
            let bottomH = scaleY(y: 12)
            let imgWH = scaleX(x: 8)
            nickNameLabel.frame = CGRect(x: scaleX(x: 80), y:bottomY, width: bottomW, height: bottomH)
            timeFromNowLabel.frame = CGRect(x: nickNameLabel.right + scaleX(x: 15), y:bottomY, width: bottomW, height: bottomH)
            zanImgView.frame = CGRect(x: timeFromNowLabel.right + scaleX(x: 5), y:bottomY + (bottomH - imgWH) / 2, width: imgWH, height: imgWH)
            upvoteLabel.frame = CGRect(x: zanImgView.right + scaleX(x: 5), y:bottomY, width: bottomW, height: bottomH)
            hitsImgView.frame =  CGRect(x: upvoteLabel.right + scaleX(x: 15), y:bottomY + (bottomH - imgWH) / 2, width: imgWH, height: imgWH)
            hitsLabel.frame  = CGRect(x: hitsImgView.right + scaleX(x: 5), y:bottomY, width: bottomW, height: bottomH)
            
        }
      
       
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
