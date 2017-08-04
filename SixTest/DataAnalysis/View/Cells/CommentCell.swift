//
//  CommentCell.swift
//  SixTest
//
//  Created by IMAC on 2017/8/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol CommentCelldelegate : NSObjectProtocol {
    func click(cell:CommentCell,view:AnyObject)
}

class CommentCell: UITableViewCell {
    
    var commentCelldelegate:CommentCelldelegate?
    
    var model:CommentFrameModel? {
        didSet{
            iconView.frame       = model?.iconF ??  CGRect.zero
            nameLabel.frame      = model?.nameF ??  CGRect.zero
            commentBtn.frame     = model?.commentF ??  CGRect.zero
            professorLabel.frame = model?.professorF ??  CGRect.zero
            floorLabel.frame     = model?.floorF ??  CGRect.zero
            timeLabel.frame      = model?.timeF ??  CGRect.zero
            contenLabel.frame    = model?.contentF ?? CGRect.zero
            shadowView.frame     = model?.shadowF ?? CGRect.zero
            replyLabel1.frame    = model?.reply1F ??  CGRect.zero
            replyLabel2.frame    = model?.reply2F ?? CGRect.zero
            replyerLabel1.frame  = model?.replyer1F ??  CGRect.zero
            replyerLabel2.frame  = model?.replyer2F ??  CGRect.zero
            sumLabel.frame       = model?.sumF ??  CGRect.zero
            
            professorLabel.layer.cornerRadius = professorLabel.height / 2
            professorLabel.layer.masksToBounds = true
            iconView.layer.cornerRadius = iconView.height / 2
            iconView.layer.masksToBounds = true
            
            iconView.sd_setImage(with: URL(string: model?.listModel?.replyerHeadPortraitFullPath ?? ""), placeholderImage: UIImage(named: "默认头像"))
            nameLabel.text = model?.listModel?.replyer?.nickName
            commentBtn.setImage(UIImage(named: "评论图标"), for: UIControlState.normal)
            if model?.listModel?.replyer?.userRole ==  "EXPERT"{
                professorLabel.text = "专家"
                professorLabel.isHidden = false
            }else{
                professorLabel.isHidden = true
            }
            
            floorLabel.text = "1楼"
            timeLabel.text = model?.listModel?.displayReplyTime
            contenLabel.text = model?.listModel?.reply?.content
            
            if model?.listModel?.childReplyList?.count ?? 0 > 0 {
                replyLabel1.isHidden = false
                replyerLabel1.isHidden = false
                replyLabel1.text = "\(model?.listModel?.childReplyList?[0].reply?.content ?? "")"
                let reply  = model?.listModel?.childReplyList?[0].replyer?.nickName ?? ""
                let replyTo = (model?.listModel?.childReplyList?[0].replyTo?.nickName ?? model?.listModel?.replyer?.nickName) ?? ""
                replyerLabel1.text = "\(reply) 回复 \(replyTo)"
                let attStr = NSMutableAttributedString(string: replyerLabel1.text ?? "")
                attStr.addAttribute(NSForegroundColorAttributeName, value: UIColorFromRGB(rgbValue: kBlueColor), range: NSMakeRange(0, reply.characters.count))
                attStr.addAttribute(NSForegroundColorAttributeName, value: UIColorFromRGB(rgbValue: kBlueColor), range: NSMakeRange(reply.characters.count + 4, replyTo.characters.count))
                replyerLabel1.attributedText = attStr
                replyerLabel1.yb_addAttributeTapAction(with: [reply,replyTo], tapClicked: {
                    [weak self]
                    (string:String?, range:NSRange, int:Int) in
                    guard let weakself = self,
                          let label = self?.replyerLabel1
                        else {
                        return
                    }
                    weakself.commentCelldelegate?.click(cell: weakself, view: label)
                    print("点击了\(string ?? "")标签 - {\(range.location) , \(range.length)} - \(int)")
                })
            }else{
                replyLabel1.isHidden = true
                replyerLabel1.isHidden = true
            }
            
            if model?.listModel?.childReplyList?.count ?? 0 > 1 {
                replyLabel2.isHidden = false
                replyerLabel2.isHidden = false
                let reply  = model?.listModel?.childReplyList?[1].replyer?.nickName ?? ""
                let replyTo = (model?.listModel?.childReplyList?[1].replyTo?.nickName ?? model?.listModel?.replyer?.nickName) ?? ""
                replyerLabel2.text = "\(reply) 回复 \(replyTo)"
                replyLabel2.text = "\(model?.listModel?.childReplyList?[1].reply?.content ?? "")"
                let attStr = NSMutableAttributedString(string: replyerLabel2.text ?? "")
                attStr.addAttribute(NSForegroundColorAttributeName, value: UIColorFromRGB(rgbValue: kBlueColor), range: NSMakeRange(0, reply.characters.count))
                attStr.addAttribute(NSForegroundColorAttributeName, value: UIColorFromRGB(rgbValue: kBlueColor), range: NSMakeRange(reply.characters.count + 4, replyTo.characters.count))
                replyerLabel2.attributedText = attStr
                replyerLabel2.yb_addAttributeTapAction(with: [reply,replyTo], tapClicked: {
                    [weak self]
                    (string:String?, range:NSRange, int:Int) in
                    
                    guard let weakself = self,
                        let label = self?.replyerLabel2
                        else {
                            return
                    }
                    weakself.commentCelldelegate?.click(cell: weakself, view: label)
                    print("点击了\(string ?? "")标签 - {\(range.location) , \(range.length)} - \(int)")
                })

            }else{
                replyLabel2.isHidden = true
                replyerLabel2.isHidden = true
            }
            
            if model?.listModel?.childReplyList?.count ?? 0 > 2 {
                sumLabel.text = "共\(model?.listModel?.childReplyList?.count ?? 0)回复"
                sumLabel.isHidden = false
            }else{
                sumLabel.isHidden = true
            }
           
        }
    }
    
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
    //回复者1
    lazy var replyerLabel1:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //回复者2
    lazy var replyerLabel2:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //回复内容1
    lazy var replyLabel1:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //回复内容2
    lazy var replyLabel2:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
    //大于2 显示共几条回复
    lazy var sumLabel:UILabel = self.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlueColor))
    //北京
    lazy var shadowView:UIView = UIView()
    
    // MARK: 初始化和生命周期
    static let cellID = "HistoryCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> CommentCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = CommentCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! CommentCell
        
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
        contentView.addSubview(shadowView)
        
        contentView.addSubview(replyerLabel1)
        contentView.addSubview(replyerLabel2)
        contentView.addSubview(replyLabel1)
        contentView.addSubview(replyLabel2)
        contentView.addSubview(sumLabel)
        
        professorLabel.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        sumLabel.isUserInteractionEnabled = true
        sumLabel.addGestureRecognizer(tap)
        
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        iconView.isUserInteractionEnabled = true
        iconView.addGestureRecognizer(iconTap)
            
        replyerLabel1.tag = 10
        replyerLabel2.tag = 11
        sumLabel.tag = 12
        
        commentBtn.addTarget(self, action: #selector(click), for: .touchUpInside)
      
        shadowView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        professorLabel.backgroundColor = UIColor.red
        professorLabel.textColor = UIColor.white

    }
 
    func addLabel(fontSize:CGFloat,textColor:UIColor) -> (UILabel) {
        let label = UILabel()
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .left
        label.textColor = textColor
        label.numberOfLines = 0
        return label
    }
    // MARK: Target方法
    func click(btn:UIButton) -> () {
        commentCelldelegate?.click(cell: self, view: btn)
    }
    
    func tapClick(tap:UITapGestureRecognizer) {
        commentCelldelegate?.click(cell: self, view: tap.view!)
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
