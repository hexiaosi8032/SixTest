//
//  ReplyListModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class ReplyListModel: NSObject {

    var childReplyList:[ChildReplyListModel]?
    var reply:ReplyModel?
    var replyer:ReplyerModel?
    var displayReplyTime:String?
    var replyerHeadPortraitFullPath:String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        
        return ["childReplyList":ChildReplyListModel.self]
        
    }
}
