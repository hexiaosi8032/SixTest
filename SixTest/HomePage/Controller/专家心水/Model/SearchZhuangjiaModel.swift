//
//  SearchZhuangjiaModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class SearchZhuangjiaModel: NSObject {
    var headPortrait:String?//为空表示没有设置头像
    var nickName:String?//昵称
    var ID:String? //用户id
    var totalRecommend:String?//总心水数
    var totalWin:Int?//总胜利次数
    var followed:String?//Y：已关注，N：未关注
    var pages:String?//总页数
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
}
