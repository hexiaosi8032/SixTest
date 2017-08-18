//
//  ChatListModel.swift
//  SixTest
//
//  Created by hxs on 2017/8/18.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ChatListModel: NSObject {

    var ID:String?
    var name:String?
    var owner:String?
    var userCount:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
