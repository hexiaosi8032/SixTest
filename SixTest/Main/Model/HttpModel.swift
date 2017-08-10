//
//  HttpModel.swift
//  SixTest
//
//  Created by IMAC on 2017/6/2.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class HttpModel: NSObject {

    var data:AnyObject?
    var statusCode:String?
    var error:Error?
    var message:String?
    //响应头
    var responseHeader = [String:Any]()
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
