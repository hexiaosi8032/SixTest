//
//  UrlConstants.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

    //默认服务器
    var kDefaultDomain:String       = "http://192.168.0.140:6060";

    // MARK: 历史开奖模块接口
    //专家心水列表
    let kProfessionalHintsListPort = "/mobile/recommend/get_recommend_records_date"
    //专家搜索接口r
    let kSearchExpertListPort = "/mobile/recommend/search_expert_list"
    //关注专家
    let kFollowExpertListPort = "/mobile/carefor/user_to_carefor"
    //查询是否已经关注
    let kCheckIsFollowPort = "/mobile/carefor/user_carefor"
    //排行榜
    let kProfessorWinRateListPort = "//mobile/recommend/get_recommend_records_date_by_type"
    //奖赏榜
    let kProfessionalHintsRewardListPort = "/mobile/recommend/get_recommend_records_reward_date_by_type"
    //专家历史推荐
    let kRecommendRecordHistoryListPort = "/mobile/recommend/get_recommend_record_history_list_by_userid"
    //专家本期推荐
    let kRecommendRecordThisPeriodListPort = "/mobile/recommend/get_recommend_record_this_period_list_by_userid"
    //获取单期开奖信息
    let kSinglePublishResultPort = "/mobile/recommend/get_recommend_publish_info_by_publish_dateno"
    //记录浏览
    let kHintsViewRecordPort = "/mobile/recommend_record/insert"
    //查询记录浏览
    let kQueryHintsViewRecordPort = "/mobile/recommend_record/list_record"

    // MARK: 历史开奖模块接口
    let kQueryHistoryRecordPort     = "/mobile/histroy/lottery_info"
    // MARK: 主页模块接口
    let kPublishResultPort          = "/mobile/lottery/lottery_news"

    // MARK:  论坛
    //首页帖子
    let kHintsBBSTopicPort          = "/mobile/topic_main"
    //帖子内容
    let kHintsBBSContentPort        = "/mobile/topic_detail"
    //提交帖子
    let kHintsBBSContentSubmitPort  = "/mobile/update_topic"
    //举报帖子
    let kReportBBSTopicPort         = "/mobile/tipoff/add_tipoff"
    //赞帖子
    let kLikeBBSTopicPort           = "/mobile/topic_add_upvotes"
    let kChatroomListFetchPort      = "/mobile/chatroom/list"

    //回复-主回复查询
    let kReplyMainQuery           = "/mobile/reply/findReplyList"
    ////回复-子回复查询
    let kReplyChildQuery           = "/mobile/reply/findChildReplyList"
    //回复-保存(包含主、子回复)
    let kReplySaveQuery           = "/mobile/reply/save"

    // MARK:  资料库
    //热门资料列表
    let kDataHotListPort            = "/mobile/free_info/get_freeinfo_hits_list"
    //资料类别列表
    let kDataTypeListPort           = "/mobile/free_info/get_freeinfo_type_list"
    //资料列表
    let kDataListPort               = "/mobile/free_info/get_freeinfo_list"

    // MARK: 个人中心 加密通讯分派接口
    let kAPIGatewayPort = "/mobile/api_gateway/request"
    // MARK: 个人中心
    let kGenerateAESKeyPort = "/mobile/api_gateway/generateUserKey"
    //发布帖子
    let kAPIGateWaySubmitBBSTopic = "UPDATE_TOPIC"
    //回复保存 帖子／评论
    let kAPIReplyCommentTopic = "REPLY_TOPIC"
