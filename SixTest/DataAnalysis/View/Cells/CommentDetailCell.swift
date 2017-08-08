//
//  CommentDetailCell.swift
//  SixTest
//
//  Created by hxs on 2017/8/7.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

class CommentDetailCell: UITableViewCell {

    var model:CommetDeailFrameModel? {
        didSet{
     
        }
    }
    
    var cellH:CGFloat = 0.0
    // MARK: 懒加载
    //头像
    lazy var iconView:UIImageView = UIImageView()
    //名字
    lazy var nameLabel:UILabel = self.addLabel(fontSize: 16, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //评论按钮
    lazy var commentBtn:UIButton = UIButton.addButton(imageName: "")
    //专家
    lazy var professorLabel:UILabel = self.addLabel(fontSize: 12, textColor: UIColor.white)
    //楼层
    lazy var floorLabel:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
    //时间
    lazy var timeLabel:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kNGDLightGrayFontColor))
    //内容
    lazy var contenLabel:UILabel = self.addLabel(fontSize: 15, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //回复者
    lazy var replyerLabel:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    
    // MARK: 初始化和生命周期
    static let cellID = "CommentDetailCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> CommentDetailCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = CommentDetailCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! CommentDetailCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(commentBtn)
        contentView.addSubview(professorLabel)
        contentView.addSubview(floorLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contenLabel)
        contentView.addSubview(replyerLabel)
     
        professorLabel.textAlignment = .center
        professorLabel.text = "专家"
        professorLabel.backgroundColor = UIColor.red
        professorLabel.textColor = UIColor.white
        
        floorLabel.text = "1楼"
        commentBtn.setImage(UIImage(named: "评论图标"), for: UIControlState.normal)
    }
    
    func addLabel(fontSize:CGFloat,textColor:UIColor) -> (UILabel) {
        let label = UILabel()
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        label.textColor = textColor
        label.numberOfLines = 0
        return label
    }
    
    func refresh(model:CommentDeailModel?,indexPath:IndexPath) -> () {

        let x = scaleX(x: 65)
        iconView.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 13), width: scaleX(x: 35), height: scaleX(x: 35))
        nameLabel.frame = CGRect(x: x, y: scaleY(y: 20), width: scaleX(x: 250), height: scaleX(x: 15))
        commentBtn.frame = CGRect(x: scaleX(x: 330), y: scaleY(y: 20), width: scaleX(x: 20), height: scaleX(x: 20))
        let y = nameLabel.frame.maxY + scaleY(y: 10)
        if indexPath.row == 0 {
            self.backgroundColor = UIColor.white
            iconView.sd_setImage(with: URL(string: model?.imgStr ?? ""), placeholderImage: UIImage(named: "默认头像"))
            nameLabel.text = model?.nameStr
            timeLabel.text = model?.timeStr
            contenLabel.text = model?.content
            
            floorLabel.isHidden = false
            contenLabel.isHidden = false
            replyerLabel.isHidden = true
            commentBtn.isHidden = false
            
            if model?.userRole == "EXPERT" {
                professorLabel.isHidden = false
                professorLabel.frame = CGRect(x: x, y: y, width: scaleX(x: 32), height: scaleX(x: 20))
                floorLabel.frame = CGRect(x: professorLabel.frame.maxX + scaleX(x: 10), y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }else{
                professorLabel.isHidden = true
                floorLabel.frame = CGRect(x: x, y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }
            timeLabel.frame = CGRect(x: floorLabel.frame.maxX + scaleX(x: 10), y: y, width: scaleX(x: 80), height: scaleX(x: 20))
            
            let contentSize = contenLabel.text?.sizeWithFont(font: adoptedFont(fontSize: 15), maxW: scaleX(x: 280))
            contenLabel.frame = CGRect(x: x , y: timeLabel.frame.maxY + scaleY(y: 10), width: contentSize!.width, height: contentSize!.height)
            cellH = contenLabel.frame.maxY + scaleY(y: 10)
            
        }else{
            self.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
            iconView.sd_setImage(with: URL(string: model?.replyerHeadPortraitFullPath ?? ""), placeholderImage: UIImage(named: "默认头像"))
            nameLabel.text = model?.replyer?.nickName
            timeLabel.text = model?.displayReplyTime
            contenLabel.text = model?.reply?.content
            
            commentBtn.isHidden = true
            floorLabel.isHidden = true
            contenLabel.isHidden = true
            replyerLabel.isHidden = false
            if model?.replyer?.userRole ==  "EXPERT"{
                professorLabel.isHidden = false
                professorLabel.frame = CGRect(x: x, y: y, width: scaleX(x: 32), height: scaleX(x: 20))
                timeLabel.frame = CGRect(x: professorLabel.frame.maxX + scaleX(x: 10), y: y, width: scaleX(x: 80), height: scaleX(x: 20))
            }else{
                professorLabel.isHidden = true
                timeLabel.frame = CGRect(x: x, y: y, width: scaleX(x: 80), height: scaleX(x: 20))
            }
            
            let replyTo = "\((model?.replyTo?.nickName ?? model?.nameStr) ?? "")"
            
            replyerLabel.text = "回复 \(replyTo) \(model?.reply?.content ?? "")"
            let attStr = NSMutableAttributedString(string: replyerLabel.text ?? "")
            attStr.addAttribute(NSForegroundColorAttributeName, value: UIColorFromRGB(rgbValue: kBlueColor), range: NSMakeRange(3,replyTo.characters.count))
            replyerLabel.attributedText = attStr
            replyerLabel.yb_addAttributeTapAction(with: [replyTo], tapClicked: {
                [weak self]
                (string:String?, range:NSRange, int:Int) in
                
                print("点击了\(string ?? "")标签 - {\(range.location) , \(range.length)} - \(int)")
            })
            
            let replyerSize = replyerLabel.text?.sizeWithFont(font: adoptedFont(fontSize: 12), maxW: scaleX(x: 280))
            
            replyerLabel.frame = CGRect(x: x , y: timeLabel.frame.maxY + scaleY(y: 10), width: replyerSize!.width, height: replyerSize!.height)
            cellH = replyerLabel.frame.maxY + scaleY(y: 10)
        }
        
        professorLabel.layer.cornerRadius = professorLabel.height / 2
        professorLabel.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.height / 2
        iconView.layer.masksToBounds = true
    }
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
