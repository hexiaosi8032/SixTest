//
//  ZhuangjiaListModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ZhuangjiaListModel: NSObject {

    var dateStr:String?
    var hits:String?//查看次数
    var ID:String? //用户id
    var nickName:String?//昵称
    var recommendType:String?//心水类型
    var title:String?//标题
    var totalCount:String?//心水总数
    var updateTime:String?//心水更新时间
    var userRole:String?//用户类型 EXPERT=专家NORMAL=普通用户
    var winCount:String?//胜场
    var pageNum:String?//当前页数
    var pages:String?//总页数
    var imageUrl:String?//图片url
    var nextPublishDateNo:String?//下一期开奖期数
    var lostCount:String?//负场
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }

}
