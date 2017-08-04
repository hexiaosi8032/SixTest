//
//  KSixType.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//

import Foundation

enum KSixType : Int {
    case KSixZhuanjiaXinshuiType = 0//专家心水
    case KSixZhuanjiaHistoryType    //查看专家历史推荐
    case KSixZhuanjiaPaiHangType    //专家排行榜
    case KSixZhuanjiaJiangShangType //专家奖赏榜
}

enum KHintsType : Int {
    case KHomeTexiaoType             //特肖
    case KHomeTemaType               //特码
    case KHomeBoseType               //波色
    case KHomeDaxiaoType             //大小
    case KHomeDanshuangType          //单双
    case KHomeWeishuType             //尾数
    case KHomeYixiaoType             //一肖
}
