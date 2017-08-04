//
//  ReplyerModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ReplyerModel: NSObject {

    var ID:String?
    var status :String?
    var totalLost :String?
    var userRole :String?
    var headPortrait :String?
    var totalWin :String?
    var nickName  :String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
