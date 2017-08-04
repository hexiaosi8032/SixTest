//
//  BallsView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/19.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class BallsView: UIView {

    // MARK: didSet
    var model:ZhuangjiaCurrentHistoryModel? {
        didSet{
            
        }
    }
    
    var dataArr = [String]() {
        didSet{
            
            let ballWH = scaleX(x: 40)
            let margin = scaleX(x: 15)
            
            let count = dataArr.count < 6 ?  CGFloat(dataArr.count) : 6.0
            let x = (ScreenWidth - ballWH * count - margin * (count - 1)) / 2.0
            
            for i in 0..<dataArr.count {
                let col = i % 6//第几列
                let row = i / 6//第几行
                let ballX = x + ballWH * CGFloat(col) + margin * CGFloat(col)
                let ballY = scaleY(y: 20) + CGFloat(row) * ballWH + margin * CGFloat(row)
                
                let btn = UIButton(type: .custom)
                btn.setBackgroundImage(UIImage(named: "未选中"), for: .normal)
                btn.isUserInteractionEnabled = false
                btn.setTitle(DataService.nameFromCode(code: dataArr[i]), for: .normal)
                btn.frame = CGRect(x: ballX, y: ballY , width: ballWH, height: ballWH)
                if i == dataArr.count - 1 {
                    frame.size.height = btn.frame.maxY + scaleY(y: 10)
                }
                
                addSubview(btn)
            }

        }
    }
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 自定义方法
    
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}
