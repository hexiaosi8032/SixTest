//
//  HomeResultModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HomeResultModel: NSObject {
    var createDate:String?
    var publishNo:String?
    var lotteryRecordDetails:NSArray?
    var nextPublishInfo:HomeNextModel?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        
        return ["lotteryRecordDetails":HomeBallModel.self]
        
    }
    
}
