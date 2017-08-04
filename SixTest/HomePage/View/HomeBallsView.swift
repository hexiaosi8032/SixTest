//
//  HomeBallsView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HomeBallsView: UIView {

    // MARK: 懒加载
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(ball1)
        self.addSubview(ball2)
        self.addSubview(ball3)
        self.addSubview(ball4)
        self.addSubview(ball5)
        self.addSubview(ball6)
        self.addSubview(addButton)
        self.addSubview(ball7)
        
        self.addSubview(textLabel1)
        self.addSubview(textLabel2)
        self.addSubview(textLabel3)
        self.addSubview(textLabel4)
        self.addSubview(textLabel5)
        self.addSubview(textLabel6)
        self.addSubview(textLabel7)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let ballWH = scaleX(x: 38)
        let ballY  = scaleY(y: 20)
        let maegin = scaleX(x: 6)
        
        ball1.frame = CGRect(x: scaleX(x: 25),  y: ballY, width: ballWH, height: ballWH)
        ball2.frame = CGRect(x: ball1.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball3.frame = CGRect(x: ball2.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball4.frame = CGRect(x: ball3.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball5.frame = CGRect(x: ball4.right + maegin, y: ballY, width: ballWH, height: ballWH)
        ball6.frame = CGRect(x: ball5.right + maegin, y: ballY, width: ballWH, height: ballWH)
        addButton.frame = CGRect(x: ball6.right + scaleX(x: 12), y: scaleY(y: 33), width: scaleX(x: 10), height: scaleX(x: 10))
        ball7.frame = CGRect(x: addButton.right + scaleX(x: 12), y: ballY, width: ballWH, height: ballWH)
        
        let labelY = ball1.bottom + scaleY(y: 10)
        let labelH = scaleY(y: 15)
        
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
        ball.textFont = adoptedFont(fontSize: 15)
        return ball
    }
    
    func addLabel() -> (UILabel) {
        let label = UILabel()
        label.textColor = UIColorFromRGB(rgbValue: kNGDBlackFontColor)
        label.font = adoptedFont(fontSize: 14)
        label.textAlignment = .center
        return label
    }
    // MARK: Target方法
    
    // MARK: HTTP请求

}
