//
//  CommentFrameModel.swift
//  SixTest
//
//  Created by IMAC on 2017/8/1.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class CommentFrameModel: NSObject {

    var iconF:CGRect?
    var nameF:CGRect?
    var commentF:CGRect?
    var professorF:CGRect?
    var floorF:CGRect?
    var timeF:CGRect?
    var contentF:CGRect?
    var shadowF:CGRect?
    
    var replyer1F:CGRect?
    var replyer2F:CGRect?
    var reply1F:CGRect?
    var reply2F:CGRect?
    var sumF:CGRect?
    var cellH:CGFloat = 0
    
    var listModel:ReplyListModel? {
        didSet{
            let x = scaleX(x: 65)
            iconF = CGRect(x: scaleX(x: 15), y: scaleY(y: 13), width: scaleX(x: 35), height: scaleX(x: 35))
            nameF = CGRect(x: x, y: scaleY(y: 20), width: scaleX(x: 250), height: scaleX(x: 15))
            commentF = CGRect(x: scaleX(x: 330), y: scaleY(y: 20), width: scaleX(x: 20), height: scaleX(x: 20))
            let y = (nameF?.maxY)! + scaleY(y: 10)
            let lineHeight:CGFloat = scaleY(y: 10)
            if listModel?.replyer?.userRole == "EXPERT" {
                professorF = CGRect(x: x, y: y, width: scaleX(x: 32), height: scaleX(x: 20))
                floorF = CGRect(x: (professorF?.maxX)! + scaleX(x: 10), y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }else{
                floorF = CGRect(x: x, y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }
            
            timeF = CGRect(x: (floorF?.maxX)! + scaleX(x: 10), y: y, width: scaleX(x: 80), height: scaleX(x: 20))

            let contentSize = (listModel?.reply?.content ?? "").sizeWithFont(font: adoptedFont(fontSize: 15), maxW: scaleX(x: 295), lineH: lineHeight)

            contentF = CGRect(x: scaleX(x: 65), y: (timeF?.maxY)! + scaleY(y: 10), width: contentSize.width, height: contentSize.height)
            
            cellH = (contentF?.maxY ?? 0) + scaleY(y: 20)
            
            if listModel?.childReplyList?.count ?? 0 > 0 {
                let replyTo = listModel?.childReplyList?[0].replyTo?.nickName ?? listModel?.replyer?.nickName
                let replyerSize1 = "\(listModel?.childReplyList?[0].replyer?.nickName ?? "") 回复 \(replyTo ?? "")".sizeWithFont(font: adoptedFont(fontSize: 12), maxW: scaleX(x: 280), lineH: lineHeight)
                replyer1F = CGRect(x: x + scaleX(x: 15), y: (contentF?.maxY)! + scaleY(y: 40), width: replyerSize1.width, height: replyerSize1.height)
                let replySize1 = "\(listModel?.childReplyList?[0].reply?.content ?? "")".sizeWithFont(font: adoptedFont(fontSize: 12), maxW: scaleX(x: 280),lineH: lineHeight)
                reply1F = CGRect(x: x + scaleX(x: 15), y: (replyer1F?.maxY)! + scaleY(y: 10), width: replySize1.width, height: replySize1.height)
               
                let shadowY = (contentF?.maxY)! + scaleY(y: 20)
                shadowF = CGRect(x: x, y: shadowY, width: scaleX(x: 295), height: (reply1F?.maxY ?? 0) - shadowY + scaleY(y: 20))
                cellH = (shadowF?.maxY ?? 0) + scaleY(y: 10)
            }
           
            if listModel?.childReplyList?.count ?? 0 > 1 {
                let replyTo = listModel?.childReplyList?[1].replyTo?.nickName ?? listModel?.replyer?.nickName
                let replyerSize2 = "\(listModel?.childReplyList?[1].replyer?.nickName ?? "") 回复 \(replyTo ?? "")".sizeWithFont(font: adoptedFont(fontSize: 12), maxW: scaleX(x: 280),lineH: lineHeight)
                replyer2F = CGRect(x: x + scaleX(x: 15), y: (reply1F?.maxY)! + scaleY(y: 10), width: replyerSize2.width, height: replyerSize2.height)
                let replySize2 = "\(listModel?.childReplyList?[1].reply?.content ?? "")".sizeWithFont(font: adoptedFont(fontSize: 12), maxW: scaleX(x: 280),lineH: lineHeight)
                reply2F = CGRect(x: x + scaleX(x: 15), y: (replyer2F?.maxY)! + scaleY(y: 10), width: replySize2.width, height: replySize2.height)
                let shadowY = (contentF?.maxY)! + scaleY(y: 20)
                shadowF = CGRect(x: x, y: shadowY, width: scaleX(x: 295), height: (reply2F?.maxY ?? 0) - shadowY + scaleY(y: 20))
                cellH = (shadowF?.maxY ?? 0) + scaleY(y: 10)
            }
            
            if listModel?.childReplyList?.count ?? 0 > 2 {
                sumF = CGRect(x: x + scaleX(x: 15), y: (reply2F?.maxY)! + scaleY(y: 10), width: scaleX(x: 80), height: scaleX(x: 20))
                let shadowY = (contentF?.maxY)! + scaleY(y: 20)
                shadowF = CGRect(x: x, y: shadowY, width: scaleX(x: 295), height: (sumF?.maxY ?? 0) - shadowY + scaleY(y: 20))
                cellH = (shadowF?.maxY ?? 0) + scaleY(y: 10)
            }
            
        }
    }
    
}
