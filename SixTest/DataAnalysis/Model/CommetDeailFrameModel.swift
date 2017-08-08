//
//  CommetDeailFrameModel.swift
//  SixTest
//
//  Created by hxs on 2017/8/7.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class CommetDeailFrameModel: NSObject {

    var iconF:CGRect?
    var nameF:CGRect?
    var commentF:CGRect?
    var professorF:CGRect?
    var floorF:CGRect?
    var timeF:CGRect?
    var contentF:CGRect?
    var shadowF:CGRect?
    
    var replyerF:CGRect?
    var cellH:CGFloat = 0
    
    var listModel:CommentDeailModel? {
        didSet{
            let x = scaleX(x: 65)
            iconF = CGRect(x: scaleX(x: 15), y: scaleY(y: 13), width: scaleX(x: 35), height: scaleX(x: 35))
            nameF = CGRect(x: x, y: scaleY(y: 20), width: scaleX(x: 250), height: scaleX(x: 15))
            commentF = CGRect(x: scaleX(x: 330), y: scaleY(y: 20), width: scaleX(x: 20), height: scaleX(x: 20))
            let y = (nameF?.maxY)! + scaleY(y: 10)
            if listModel?.replyer?.userRole == "EXPERT" {
                professorF = CGRect(x: x, y: y, width: scaleX(x: 32), height: scaleX(x: 20))
                floorF = CGRect(x: (professorF?.maxX)! + scaleX(x: 10), y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }else{
                floorF = CGRect(x: x, y: y, width: scaleX(x: 20), height: scaleX(x: 20))
            }
            
            timeF = CGRect(x: (floorF?.maxX)!, y: y, width: scaleX(x: 80), height: scaleX(x: 20))
            
            let contentSize = (listModel?.reply?.content ?? "").sizeWithFont(font: adoptedFont(fontSize: 15), maxW: scaleX(x: 295))
            contentF = CGRect(x: scaleX(x: 65), y: (timeF?.maxY)! + scaleY(y: 10), width: contentSize.width, height: contentSize.height)
            
            cellH = (contentF?.maxY ?? 0) + scaleY(y: 20)
            
        }
    }
}
