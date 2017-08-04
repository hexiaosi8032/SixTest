//
//  HintsBBSModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/23.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HintsBBSModel: NSObject {

    var content:String?//文章内容
    var createTime:String?//创建日期
    var hits:String?//浏览数
    var isEssence:String?//是否为精华帖
    var isTop:String?//是否为置顶贴
    var nickName:String?//用户昵称
    var publishNo:String?//期号
    var timeFromNow:String?//发布的时间到现在的时间
    var title:String?//题目
    var updateTime:String?//最新一次更新的时间
    var upvote:String?//点赞的数量
    var userId:String?//用户id
    var userRole:String?////用户的角色 EXPERT专家  NORMAL普通用户
    var pageNum:String?//返回的页数
    var pages:String?//总页数
    var publishDateNo:String?//当前期号
    
    //帖子详情
    var publishNoNow:String?//最新期号
    var status:String = "0"//帖子状态
}
