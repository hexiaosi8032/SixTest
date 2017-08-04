//
//  HistoryCell.swift
//  SixTest
//
//  Created by IMAC on 2017/6/2.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    var label:UILabel?
    
    var model:HistoryModel? {
        didSet{

            titleLabel.text = getTitleString(titleStr: model?.publishNo ?? "")
            timeLabel.text  = getTimeString(timeStr: model?.publishDateNo ?? "")
            
            ball1.text = (model?.lotteryRecordDetails?[0] as? HomeBallModel)?.no ?? ""
            ball2.text = (model?.lotteryRecordDetails?[1] as? HomeBallModel)?.no ?? ""
            ball3.text = (model?.lotteryRecordDetails?[2] as? HomeBallModel)?.no ?? ""
            ball4.text = (model?.lotteryRecordDetails?[3] as? HomeBallModel)?.no ?? ""
            ball5.text = (model?.lotteryRecordDetails?[4] as? HomeBallModel)?.no ?? ""
            ball6.text = (model?.lotteryRecordDetails?[5] as? HomeBallModel)?.no ?? ""
            ball7.text = (model?.lotteryRecordDetails?[6] as? HomeBallModel)?.no ?? ""
    
            ball1.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[0] as? HomeBallModel)?.color ?? "RED")
            ball2.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[1] as? HomeBallModel)?.color ?? "RED")
            ball3.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[2] as? HomeBallModel)?.color ?? "RED")
            ball4.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[3] as? HomeBallModel)?.color ?? "RED")
            ball5.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[4] as? HomeBallModel)?.color ?? "RED")
            ball6.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[5] as? HomeBallModel)?.color ?? "RED")
            ball7.type = DataService.colorFromBallType(colorStr: (model?.lotteryRecordDetails?[6] as? HomeBallModel)?.color ?? "RED")
 
            
            textLabel1.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[0] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel2.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[1] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel3.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[2] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel4.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[3] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel5.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[4] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel6.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[5] as? HomeBallModel)?.shengxiao ?? "DOG")
            textLabel7.text = DataService.nameFromCode(code: (model?.lotteryRecordDetails?[6] as? HomeBallModel)?.shengxiao ?? "DOG")
            
        }
    }
    
    // MARK: 懒加载
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColorFromRGB(rgbValue: kBlackFontColor)
        label.font = adoptedFont(fontSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var timeLabel:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var ball1:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var ball2:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var ball3:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var ball4:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var ball5:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var ball6:BallView = {
        let ball = self.addBall()
        return ball
    }()
    
    lazy var addButton:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setBackgroundImage(UIImage(named: "加号"), for: .normal)
        return btn
    }()
    
    lazy var ball7:BallView = {
        let ball = self.addBall()
        return ball
    }()

    lazy var textLabel1:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel2:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel3:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel4:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel5:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel6:UILabel = {
        let label = self.addLabel()
        return label
    }()
    
    lazy var textLabel7:UILabel = {
        let label = self.addLabel()
        return label
    }()

    
    // MARK: 初始化和生命周期
    static let cellID = "HistoryCell"
    
    class func cellWithTableView(_ tableView:UITableView) -> HistoryCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil{
            cell = HistoryCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            tableView.separatorStyle = .none
        }
        
        return cell as! HistoryCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(ball1)
        contentView.addSubview(ball2)
        contentView.addSubview(ball3)
        contentView.addSubview(ball4)
        contentView.addSubview(ball5)
        contentView.addSubview(ball6)
        contentView.addSubview(addButton)
        contentView.addSubview(ball7)
        
        contentView.addSubview(textLabel1)
        contentView.addSubview(textLabel2)
        contentView.addSubview(textLabel3)
        contentView.addSubview(textLabel4)
        contentView.addSubview(textLabel5)
        contentView.addSubview(textLabel6)
        contentView.addSubview(textLabel7)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: scaleX(x: 12), y: scaleY(y: 17), width: scaleX(x: 60), height: scaleY(y: 15))
        timeLabel.frame  = CGRect(x: scaleX(x: 14), y: scaleY(y: 45), width: scaleX(x: 60), height: scaleY(y: 15))
        
        let ballWH = scaleX(x: 27)
        let ballY  = scaleY(y: 11)
        let maegin = scaleX(x: 11)
        let x      = titleLabel.right + scaleX(x: 20)
        
        ball1.frame = CGRect(x: x,  y: ballY, width: ballWH, height: ballWH)
        ball2.frame = CGRect(x: ball1.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball3.frame = CGRect(x: ball2.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball4.frame = CGRect(x: ball3.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball5.frame = CGRect(x: ball4.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball6.frame = CGRect(x: ball5.right + maegin, y: ballY, width: ballWH, height: ballWH)
        addButton.frame = CGRect(x: ball6.right + maegin, y: scaleY(y: 18), width: scaleX(x: 10), height: scaleX(x: 10))
        ball7.frame = CGRect(x: addButton.right + maegin, y: ballY, width: ballWH, height: ballWH)
        
        let labelY = ball1.bottom + scaleY(y: 10)
        let labelH = scaleY(y: 10)
        
        textLabel1.frame = CGRect(x: ball1.left,  y: labelY, width: ballWH, height: labelH)
        textLabel2.frame = CGRect(x: ball2.left,  y: labelY, width: ballWH, height: labelH)
        textLabel3.frame = CGRect(x: ball3.left,  y: labelY, width: ballWH, height: labelH)
        textLabel4.frame = CGRect(x: ball4.left,  y: labelY, width: ballWH, height: labelH)
        textLabel5.frame = CGRect(x: ball5.left,  y: labelY, width: ballWH, height: labelH)
        textLabel6.frame = CGRect(x: ball6.left,  y: labelY, width: ballWH, height: labelH)
        textLabel7.frame = CGRect(x: ball7.left,  y: labelY, width: ballWH, height: labelH)
        
    }
    
    // MARK: 自定义方法
    func addBall() -> (BallView) {
        let ball = BallView()
        ball.textFont = adoptedFont(fontSize: 11)
        ball.type = .ballTypeRed
        return ball
    }
    
    func addLabel() -> (UILabel) {
        let label = UILabel()
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        label.font = adoptedFont(fontSize: 11)
        label.textAlignment = .center
        return label
    }
 
    func getTitleString(titleStr:String) -> (String) {
        let string = String(format: "%03d", NSInteger(titleStr)!)
        return "\(string)期"
    }

    func getTimeString(timeStr:String) -> (String) {
 
        if timeStr.characters.count < 8{
            return ""
        }
        
        let fitstSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 4)
        let fitstEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 6)
        let monStr = timeStr.substring(with: fitstSubIndex..<fitstEndIndex)
        
        let secondSubIndex   = timeStr.index(timeStr.startIndex, offsetBy: 6)
        let secondEndIndex   = timeStr.index(timeStr.startIndex, offsetBy: 8)
        let dayStr = timeStr.substring(with: secondSubIndex..<secondEndIndex)
        
        return "\(monStr)月\(dayStr)日"
    }

    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
