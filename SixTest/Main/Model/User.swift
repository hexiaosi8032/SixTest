//
//  User.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class User: NSObject {

    var isLogin:Bool?
    var userName:String?
    var userID:String?
    var publishDateNo:String?
    
    static let instance:User = User()
    class func sharedInstance() -> User {
        return instance
    }
    
}
