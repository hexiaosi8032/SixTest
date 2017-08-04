//
//  HomeBgView.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HomeBgView: UIView {

    // MARK: 懒加载
    lazy var resuletView:HomeResultView = {
        let resuletView = HomeResultView()
        return resuletView
    }()
    
    lazy var ballsView:HomeBallsView = {
        let ballsView = HomeBallsView()
        return ballsView
    }()
    
    lazy var timeShowView:HomeTimeShowView = {
        let timeShowView = HomeTimeShowView()
        return timeShowView
    }()
    
    lazy var bannerView:HomeBannerView = {
        let bannerView = HomeBannerView()
        bannerView.backgroundColor = UIColorFromRGB(rgbValue: kMainThemeColor)
        return bannerView
    }()
    
    lazy var listView:HomeListView = {
        let listView = HomeListView()
        return listView
    }()
    
    // MARK: 初始化和生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(resuletView)
        self.addSubview(ballsView)
        self.addSubview(timeShowView)
        self.addSubview(bannerView)
        self.addSubview(listView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        resuletView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scaleY(y: 40))
        resuletView.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 1)
        
        ballsView.frame = CGRect(x: 0, y: resuletView.frame.maxY, width: ScreenWidth, height: scaleY(y: 110))
        ballsView.addBottomLine(color: UIColorFromRGB(rgbValue: kLineColor), lineHeight: 1)
        
        timeShowView.frame = CGRect(x: 0, y: ballsView.frame.maxY, width: ScreenWidth, height: scaleY(y: 30))
        
        bannerView.frame = CGRect(x: 0, y: timeShowView.frame.maxY, width: ScreenWidth, height: scaleY(y: 145))

        listView.frame = CGRect(x: 0, y: bannerView.frame.maxY, width: ScreenWidth, height: frame.size.height - bannerView.frame.maxY)
    }
    
    // MARK: 自定义方法
    func refresh(_ resultModel:HomeResultModel) -> () {
        
        
        let string:String = String(format: "%03d", NSInteger(resultModel.publishNo ?? "1")!)
        resuletView.resultLabel.text = "第\(string)期开奖结果:"
        resuletView.resultLabel.attributedText = resuletView.resultLabel.addContentColor(title: resuletView.resultLabel.text!, changeTitle: string, changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
        
        ballsView.ball1.text = (resultModel.lotteryRecordDetails?[0] as? HomeBallModel)?.no ?? ""
        ballsView.ball2.text = (resultModel.lotteryRecordDetails?[1] as? HomeBallModel)?.no ?? ""
        ballsView.ball3.text = (resultModel.lotteryRecordDetails?[2] as? HomeBallModel)?.no ?? ""
        ballsView.ball4.text = (resultModel.lotteryRecordDetails?[3] as? HomeBallModel)?.no ?? ""
        ballsView.ball5.text = (resultModel.lotteryRecordDetails?[4] as? HomeBallModel)?.no ?? ""
        ballsView.ball6.text = (resultModel.lotteryRecordDetails?[5] as? HomeBallModel)?.no ?? ""
        ballsView.ball7.text = (resultModel.lotteryRecordDetails?[6] as? HomeBallModel)?.no ?? ""
        
        ballsView.ball1.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[0] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball2.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[1] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball3.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[2] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball4.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[3] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball5.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[4] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball6.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[5] as? HomeBallModel)?.color ?? "RED")
        ballsView.ball7.type = DataService.colorFromBallType(colorStr: (resultModel.lotteryRecordDetails?[6] as? HomeBallModel)?.color ?? "RED")
        
        ballsView.textLabel1.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[0] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel2.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[1] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel3.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[2] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel4.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[3] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel5.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[4] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel6.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[5] as? HomeBallModel)?.shengxiao ?? "DOG")
        ballsView.textLabel7.text = DataService.nameFromCode(code: (resultModel.lotteryRecordDetails?[6] as? HomeBallModel)?.shengxiao ?? "DOG")
        
        let nextModel = resultModel.nextPublishInfo
        let timeString = (nextModel?.publishDateInfo?.components(separatedBy: " ")[0]) ?? ""
       
        timeShowView.timeLabel.text = "下期开奖时间:  \(timeString)"
        timeShowView.timeLabel.attributedText = timeShowView.timeLabel.addContentColor(title: timeShowView.timeLabel.text!, changeTitle: timeString, changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
        
        let zhiboTimeString = DataService.timeStringFromCount(count: NSInteger(nextModel?.nextPublishTime ?? "1")!)
        timeShowView.zhiboLabel.text = "直播计时:  \(zhiboTimeString)"
        timeShowView.zhiboLabel.attributedText = timeShowView.zhiboLabel.addContentColor(title: timeShowView.zhiboLabel.text!, changeTitle: zhiboTimeString, changeTitleColor: UIColorFromRGB(rgbValue: kMainThemeColor))
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
 
    
    
}
