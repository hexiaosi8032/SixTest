//
//  ZhuangjiaHistoryContentModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ZhuangjiaHistoryContentModel: NSObject {

    var color:String?
    var danshuang:String?
    var daxiao:String?
    var ID:String?//开奖信息ID
    var jiaye:String?//详情参照家野表
    var lotteryRecordId:String?//主表ID离
    var no:String?//开奖期数修改时间
    var noOrder:String?//开奖号码序号
    var shengxiao:String?//详情参照生肖表
    var weishu:String?//尾数
    var wuxing:String?//详情参照五行表
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
