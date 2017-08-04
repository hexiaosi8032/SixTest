//
//  DataTypeModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class DataTypeModel: NSObject {

    var createDate:String?
    var ID:String?
    var name:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
    
}
