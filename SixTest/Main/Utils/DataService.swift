//
//  DataService.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class DataService: NSObject {

    class func hintsitleFromType(type:KHintsType) -> (String) {
       
        return  [(KHintsType.KHomeTexiaoType)    : "特肖",
                 (KHintsType.KHomeTemaType)      : "特码",
                 (KHintsType.KHomeBoseType)      : "波色",
                 (KHintsType.KHomeDaxiaoType)    : "大小",
                 (KHintsType.KHomeDanshuangType) : "单双",
                 (KHintsType.KHomeWeishuType)    : "尾数",
                 (KHintsType.KHomeYixiaoType)    : "一肖"][(type)]!
    }

    class func hintsTypeStringFormType(type:KHintsType) -> (String) {
        
        return  [(KHintsType.KHomeTexiaoType)    : "TEXIAO",
                 (KHintsType.KHomeTemaType)      : "TEMA",
                 (KHintsType.KHomeBoseType)      : "COLOR",
                 (KHintsType.KHomeDaxiaoType)    : "DAXIAO",
                 (KHintsType.KHomeDanshuangType) : "DANSHUANG",
                 (KHintsType.KHomeWeishuType)    : "WEISHU",
                 (KHintsType.KHomeYixiaoType)    : "YIXIAO"][(type)]!
    }
    
    class func hintsFromCode(code:String) -> (String) {
        
        return ["TEXIAO"    : "特肖",
                "TEMA"      : "特码",
                "COLOR"     : "波色",
                "DAXIAO"    : "大小",
                "DANSHUANG" : "单双",
                "WEISHU"    : "尾数",
                "YIXIAO"    : "一肖",
                ""          : ""][code]!
    }
    
    class func nameFromCode(code:String) -> (String) {
        var str:String = ["DOG"     : "狗",
                          "MONKEY"  : "猴",
                          "HORSE"   : "马",
                          "SNAKE"   : "蛇",
                          "DRAGON"  : "龙",
                          "RABBIT"  : "兔",
                          "TIGER"   : "虎",
                          "CATTLE"  : "牛",
                          "MOUSE"   : "鼠",
                          "PIG"     : "猪",
                          "CHICKEN" : "鸡",
                          "SHEEP"   : "羊",
                          "RED"     : "红",
                          "GREEN"   : "绿",
                          "BLUE"    : "蓝",
                          "DAN"     : "单",
                          "SHUANG"  : "双",
                          "DA"      : "大",
                          "XIAO"    : "小",
                          "JIN"     : "金",
                          "MU"      : "木",
                          "SHUI"    : "水",
                          "HUO"     : "火",
                          "TU"      : "土",][code] ?? ""
        if str == ""{
            str = code
        }
        return str
    }
    
    class func hintsOrderTypeFromName(name:String) -> (String) {
        
        return ["月胜场"     : "toMonthWins",
                "查看数"     : "toCheckNum",
                "时间"      : "toTime",
                "本月胜场"   : "toMonthWins",
                "本月连胜榜" : "toContWinCount"][name]!
    }
    
    class func timeStringFromCount(count:NSInteger) -> (String) {
        
        if count < 0 {
            return "正在开奖"
        }
        
        if count < 3600 {
            
            let min = count / 60
            let sec = count % 60
            
            return String(format: "%02d:%02d", min, sec)
            
        }else{
            
            let hour = count / 3600
            let min  = count % 3600 / 60
            let sec  = count % 3600 / 60
            
            return String(format: "%02d:%02d:%02d", hour,min, sec)
        }
    }
    
    class func colorFromBallType(colorStr:String) -> (BallView.ballType) {
        return ["RED"     : BallView.ballType.ballTypeRed,
                "GREEN"   : BallView.ballType.ballTypeGreen,
                "BLUE"    : BallView.ballType.ballTypeBlue,
                ][colorStr]!
    }
    
    class func getHistoryYears(firstYear:NSInteger) -> ([String]) {
  
        var arr = [String]()
        for i in (1976...firstYear).reversed() {
            arr.append("\(i)")
        }
        return arr
    }
    
    class func getCurrentYear() -> (NSInteger) {
        
        let nowDate = Date()
        let calendar = Calendar.current
      return calendar.component(.year, from: nowDate)
    }
    
    class func getViewControllers(_ type:KSixType) -> ([UIViewController]) {
        var titles = [UIViewController]()
        switch type {
        case .KSixZhuanjiaXinshuiType:
            let arr = ["特肖","特码","波色","大小","单双","尾数","一肖"]
            let types = [(KHintsType.KHomeTexiaoType),(KHintsType.KHomeTemaType),(KHintsType.KHomeBoseType),
                         (KHintsType.KHomeDaxiaoType),(KHintsType.KHomeDanshuangType),(KHintsType.KHomeWeishuType),
                         (KHintsType.KHomeYixiaoType),]
            for i in 0..<arr.count {
                let vc = ZhuanjiaXinshuiChidVC()
                vc.title = arr[i]
                vc.type = types[i]
                vc.numberIndexList = i + 1
                titles.append(vc)
            }
            break
        case .KSixZhuanjiaHistoryType:
            let arr = ["特肖","特码","波色","大小","单双","尾数","一肖"]
            let types = [(KHintsType.KHomeTexiaoType),(KHintsType.KHomeTemaType),(KHintsType.KHomeBoseType),
                         (KHintsType.KHomeDaxiaoType),(KHintsType.KHomeDanshuangType),(KHintsType.KHomeWeishuType),
                         (KHintsType.KHomeYixiaoType),]
            for i in 0..<arr.count {
                let vc = LookZhuangjiaHistoryListVC()
                vc.title = arr[i]
                vc.type = types[i]
//                vc.numberIndexList = i + 1
                titles.append(vc)
            }
            break
        case .KSixZhuanjiaPaiHangType,.KSixZhuanjiaJiangShangType:
            let arr = ["特肖","特码","波色","大小","单双","尾数","一肖"]
            let types = [(KHintsType.KHomeTexiaoType),(KHintsType.KHomeTemaType),(KHintsType.KHomeBoseType),
                         (KHintsType.KHomeDaxiaoType),(KHintsType.KHomeDanshuangType),(KHintsType.KHomeWeishuType),
                         (KHintsType.KHomeYixiaoType),]
            for i in 0..<arr.count {
                if type ==  .KSixZhuanjiaPaiHangType{
                    let vc = PaiHangBangChildVC()
                        vc.title = arr[i]
                    vc.type = types[i]
                    titles.append(vc)
                }else{
                    let vc = JiangShangChidVC()
                    vc.title = arr[i]
                    vc.type = types[i]
                    titles.append(vc)
                }
     
            }
            break
            
            
        default:
            break
        }
        
        return titles
    }
    //通过响应者链条获得 nav
    class func getSuperNav(controller:UIViewController) -> (UINavigationController) {
        var object = controller.next
        while (!(object?.isKind(of: UINavigationController.self))!){
            object = object?.next
        }
        let nav:UINavigationController = object as! UINavigationController
        return nav
    }
    
}
