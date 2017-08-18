//
//  ChatUserModel.swift
//  SixTest
//
//  Created by hxs on 2017/8/18.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ChatUserModel: NSObject {

    var ID:String? //用户id
    var headPortrait:String?
    var nickName:String?
    var userName:String?
    var userRole:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
