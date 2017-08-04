//
//  PaiHangBangModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/27.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class PaiHangBangModel: NSObject {

    var ID:String? //用户id
    var nickName:String? //昵称
    var totalCount:String? //心水总数
    var userRole:String? //用户类型 EXPERT=专家NORMAL=普通用户
    var winCount:String? //胜场
    var recentWinCount:String? //连胜场数
    var winPercentage:String? //胜率
    var pageNum:String? //当前页数
    var pages:String? //总页数
    var pageSize:String? //每页的行数
    var imageUrl:String? //图片url
    var lostCount:String? //负场
    var title:String?
    var reward:String? //金币
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }
    
}
