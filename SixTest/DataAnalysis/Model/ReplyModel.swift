//
//  ReplyModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ReplyModel: NSObject {

    var ID:String?
    var content:String?
    var deleteFlag:String?
    var replyTime:String?
    var replyer:String?
    var type:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
