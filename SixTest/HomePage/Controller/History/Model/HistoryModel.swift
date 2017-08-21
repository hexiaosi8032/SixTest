//
//  HistoryModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/2.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HistoryModel: NSObject {

    var createDate:String?
    var detailNoString:String?
    var lotteryRecordDetails:NSArray?
    var publishDateNo:String?
    var publishNo:String?
    var publishTime:String?
    var published:String?
    var updateDate:String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["lotteryRecordDetails":HomeBallModel.self]
        
    }
}
