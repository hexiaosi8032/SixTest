//
//  HotDataModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/28.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class HotDataModel: NSObject {
    
    var content:String?
    var createTime:String?
    var hits:String?
    var ID:String?
    var replies:String?
    var title:String?
    var typeId:String?
    var updateTime:String?
    var typeName:String?
 
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
    
}
