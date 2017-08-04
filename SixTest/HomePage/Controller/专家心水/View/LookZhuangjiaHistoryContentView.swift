//
//  LookZhuangjiaHistoryContentView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class LookZhuangjiaHistoryContentView: UIView {

    var balls      = [UILabel]()
    var color      = [String]()
    var shengxiaos = [UILabel]()
    var line1s     = [UIView]()
    var daxiaos    = [UILabel]()
    var line2s     = [UIView]()
    var danshuangs = [UILabel]()
    
    var infoModel:ZhuangjiaInfoModel? {
        didSet{
            imgView.sd_setImage(with: URL(string: infoModel?.headPortrait ?? ""), placeholderImage: UIImage(named: "默认头像"))
            userNameLabel.text = "\(infoModel?.nickName ?? "")"
        }
    }
    
    var currentModel:ZhuangjiaCurrentHistoryModel? {
        didSet{

            titleLabel.text = "    \(currentModel?.title ?? "")"
            let iswin = currentModel?.isWin == "Y" ? "胜" : "负"
            iswinLabel.backgroundColor = currentModel?.isWin == "Y" ? UIColorFromRGB(rgbValue: kMainThemeColor) : UIColorFromRGB(rgbValue: kNGDGreenColor)
            iswinLabel.text = iswin

            ballsView.dataArr = currentModel?.data?.components(separatedBy: ",") ?? []
        }
    }

    var dataArr = [ZhuangjiaHistoryContentModel]() {
        didSet{
            
            for i in 0..<dataArr.count {
                let model = dataArr[i]
                let color = colorFromColorStr(colorStr: model.color ?? "RED")
                let ball = addLabel(fontSize: 17, color: color)
                ball.layer.borderColor = color.cgColor
                ball.text = model.no ?? ""
                ball.layer.borderWidth = 2
                
                let shengxiaolabel:UILabel = addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
                shengxiaolabel.text = DataService.nameFromCode(code: model.shengxiao ?? "")
                
                let line1:UIView = UIView()
                line1.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
                
                let daxiaolabel:UILabel = addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
                daxiaolabel.text = DataService.nameFromCode(code: model.daxiao ?? "")
                
                let line2:UIView = UIView()
                line2.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
                
                let danshuanglabel:UILabel = addLabel(fontSize: 14, color: UIColorFromRGB(rgbValue: kNGDBlackFontColor))
                print(model.danshuang ?? "")
                danshuanglabel.text = DataService.nameFromCode(code: model.danshuang ?? "")
                
                addSubview(ball)
                addSubview(shengxiaolabel)
                addSubview(danshuanglabel)
                addSubview(line1)
                addSubview(daxiaolabel)
                addSubview(line2)
                addSubview(danshuanglabel)
                
                balls.append(ball)
                shengxiaos.append(shengxiaolabel)
                line1s.append(line1)
                daxiaos.append(daxiaolabel)
                line2s.append(line2)
                danshuangs.append(danshuanglabel)
            }
        }
    }
    
    // MARK: 懒加载
    lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var userNameLabel:UILabel = {
        let label = self.addLabel(fontSize: 16, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .left
        return label
    }()
    
    lazy var line1:UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line1
    }()
    
    
    lazy var line2:UIView = {
        let line2 = UIView()
        line2.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        return line2
    }()
    
    lazy var titleLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 17, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.textAlignment = .left
        return label
    }()
    
    lazy var iswinLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 13, color: UIColorFromRGB(rgbValue: kWhiteColor))
        return label
    }()
    
    lazy var resultLabel:UILabel = {
        let label:UILabel = self.addLabel(fontSize: 15, color: UIColorFromRGB(rgbValue: kBlackFontColor))
        label.text = "    开奖结果:"
        label.textAlignment = .left
        return label
    }()
    
    lazy var ballsView:BallsView = {
        let ballsView = BallsView()
        return ballsView
    }()

    lazy var addButton:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setBackgroundImage(UIImage(named: "加号"), for: .normal)
        return btn
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgView)
        addSubview(userNameLabel)
        addSubview(line1)
        addSubview(titleLabel)
        addSubview(iswinLabel)
        addSubview(ballsView)
        addSubview(line2)
        addSubview(resultLabel)
        addSubview(addButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.frame = CGRect(x: scaleX(x: 15) , y: scaleY(y: 15), width: scaleX(x: 50), height: scaleX(x: 50))
        imgView.layer.cornerRadius = imgView.width / 2
        imgView.layer.masksToBounds = true
        
        userNameLabel.frame = CGRect(x: imgView.right + scaleX(x: 15), y: scaleY(y: 35), width: scaleX(x: 200), height: scaleY(y: 15))
        
        line1.frame = CGRect(x: 0, y: imgView.bottom + scaleY(y: 15), width: width, height: 0.5)
        titleLabel.frame = CGRect(x: 0, y: line1.bottom + scaleY(y: 15), width: width, height: scaleY(y: 15))
        titleLabel.sizeToFit()
        
        iswinLabel.frame = CGRect(x: titleLabel.right + scaleX(x: 5), y: titleLabel.y + scaleY(y: 2), width: scaleX(x: 12), height: scaleY(y: 11))
        iswinLabel.layer.cornerRadius = 2
        iswinLabel.layer.masksToBounds = true
        iswinLabel.sizeToFit()
        iswinLabel.center.y = titleLabel.center.y

        ballsView.frame = CGRect(x: 0, y: titleLabel.bottom, width: width, height: ballsView.height)
        line2.frame = CGRect(x: 0, y: ballsView.bottom + scaleY(y: 15), width: width, height: 0.5)
        resultLabel.frame = CGRect(x: 0, y: line2.bottom + scaleY(y: 10), width: width, height: scaleY(y: 15))
        
        let ballWH = scaleX(x: 30)
        let labelH = scaleY(y: 15)
        let y = resultLabel.bottom + scaleY(y: 15)
        let marginY = scaleY(y: 10)
        
        for i in 0..<dataArr.count {
            
            let margin = (width - ballWH * 8) / 9
            var x = margin * CGFloat(i + 1) + ballWH * CGFloat(i)
            if i == dataArr.count - 1 {
                let addBtnY = y + scaleX(x: 7)
                let addBtnX = x + scaleX(x: 7)
                addButton.frame = CGRect(x: addBtnX, y: addBtnY, width: scaleX(x: 16), height: scaleX(x: 16))
                x = margin * CGFloat(i + 2) + ballWH * CGFloat(i + 1)
            }
            
            
            let ball:UILabel = balls[i]
            let shengxiaolabel:UILabel = shengxiaos[i]
            let line1:UIView = line1s[i]
            let daxiaolabel:UILabel = daxiaos[i]
            let line2:UIView = line2s[i]
            let danshuanglabel:UILabel = danshuangs[i]
            
            ball.frame = CGRect(x: x, y: y, width: ballWH, height: ballWH)
            ball.layer.cornerRadius = ballWH / 2
            ball.layer.masksToBounds = true
            
            var tempY = ball.bottom + marginY
            
            shengxiaolabel.frame = CGRect(x: x, y: tempY, width: ballWH, height: labelH)
            tempY = shengxiaolabel.bottom + marginY
            
            line1.frame = CGRect(x: shengxiaolabel.center.x, y: tempY, width: 1, height: ballWH)
            tempY = line1.bottom + marginY
            
            daxiaolabel.frame    = CGRect(x: x, y: tempY, width: ballWH, height: labelH)
            tempY = daxiaolabel.bottom + marginY
            
            line2.frame = CGRect(x: shengxiaolabel.center.x, y: tempY, width: 1, height: ballWH)
            tempY = line2.bottom + marginY
            
            danshuanglabel.frame = CGRect(x: x, y: tempY, width: ballWH, height: labelH)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: 自定义方法
    func addLabel(fontSize:CGFloat,color:UIColor) -> (UILabel) {
        let label = UILabel()
        label.textColor = color
        label.font = adoptedFont(fontSize: fontSize)
        label.textAlignment = .center
        return label
    }

    func colorFromColorStr(colorStr:String) -> UIColor {
        return  ["RED"   : UIColorFromRGB(rgbValue: kMainThemeColor),
                 "BLUE"  : UIColorFromRGB(rgbValue: kBlueColor),
                 "GREEN" : UIColorFromRGB(rgbValue: kNGDGreenColor)][(colorStr)]!
        
    }
    
    func addLine(y:CGFloat) -> (UIView) {
        let line = UIView()
        line.backgroundColor = UIColorFromRGB(rgbValue: kLineColor)
        line.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: 0.5)
        return line
    }

}
