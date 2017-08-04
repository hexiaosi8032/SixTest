//
//  ZhuangjiaCurrentHistoryModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/20.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ZhuangjiaCurrentHistoryModel: NSObject {

    //本期推荐
    var dateStr:String?//心水时间跟当前时间的距离
    var recentWinCount:String?//最近连胜场数
    var title:String?//心水标题
    var totalCount:String?//总场数
    var winCount:String?//胜场
    var lostCount:String?//负场type
    //== 公用部分
    var hits:String?//查看数
    var data:String?//特码详情
    var type:String?//心水类型（如TAMA、TEXIAO）
    var updateTime:String?//心水修改时间
    var userid:String?//用户id
    //历史推荐
    var createTime:String?//心水创建时间
    var isWin:String? //是否胜利（Y-赢 N-输 I-未开奖）
    var ID:String?
    var publishDateNo:String?//当前心水对应期数（如：003）
    var upvote:String?//点赞次数
    var pageNum:String? //当前页数
    var pages:String? //总页数
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID" : "id"]
    }

    
}
